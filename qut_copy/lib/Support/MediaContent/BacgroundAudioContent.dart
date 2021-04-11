
import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:qut/Models/Content.dart';



class QueueState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;

  QueueState(this.queue, this.mediaItem);
}

class MediaState {
  final MediaItem mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}



// NOTE: Your entrypoint MUST be a top-level function.
void audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

/// This task defines logic for playing a list of podcast episodes.
class AudioPlayerTask extends BackgroundAudioTask {

 Content content;



  AudioPlayer _player = new AudioPlayer();
  AudioProcessingState _skipState;
  StreamSubscription<PlaybackEvent> _eventSubscription;

  int get index => _player.currentIndex;
  MediaItem get mediaItem => index == null ? null : queue[index];

  List<MediaItem> get queue {
    return <MediaItem>[
    MediaItem(
      id: content.content_link,
      album: "name",
      title: "QUT",
      artist: content.name,
      duration: Duration(seconds: content.content_qut_duration),
      artUri: Uri.parse(content.content_preview),
    ),

  ];
  }

  

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    content = Content.fromJson(params);

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    _player.currentIndexStream.listen((index) {
      if (index != null) AudioServiceBackground.setMediaItem(queue[index]);
    });
    _eventSubscription = _player.playbackEventStream.listen((event) {
      _broadcastState();
    });
    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          onStop();
          break;
        case ProcessingState.ready:
          _skipState = null;
          break;
        default:
          break;
      }
    });

    AudioServiceBackground.setQueue(queue);
    try {
      await _player.setAudioSource(ConcatenatingAudioSource(
        children:
            queue.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ));
      onPlay();
    } catch (e) {
      print("Error: $e");
      onStop();
    }
  }

  @override
  Future<void> onSkipToQueueItem(String mediaId) async {

    final newIndex = queue.indexWhere((item) => item.id == mediaId);

    if (newIndex == -1) return;

    _skipState = newIndex > index
        ? AudioProcessingState.skippingToNext
        : AudioProcessingState.skippingToPrevious;
    _player.seek(Duration.zero, index: newIndex);
    AudioServiceBackground.sendCustomEvent('skip to $newIndex');
  }

  @override
  Future<void> onPlay(){
    print('save play');
    _player.play();
  }

  @override
  Future<void> onPause(){
    print('save payse');
    _player.pause();
    
  }


  @override
  Future<void> onSeekTo(Duration position) => _player.seek(position);

    @override
  Future<void> onSeekForward(bool begin) async => _player.pause();

  @override
  Future<void> onSeekBackward(bool begin) async => _player.pause();


  @override
  Future<void> onStop() async {
    await _player.stop();
    await _player.dispose();
    _eventSubscription.cancel();

    await _broadcastState();
    return await super.onStop();
  }

  Future<void> _broadcastState() async {
    await AudioServiceBackground.setState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: [
        MediaAction.seekTo,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      ],
      androidCompactActions: [0, 1, 3],
      processingState: _getProcessingState(),
      playing: _player.playing,
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
    );
  }

  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState;
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.stopped;
      case ProcessingState.loading:
        return AudioProcessingState.connecting;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: ${_player.processingState}");
    }
  }
}






class Timeline {

  String word;
  String start_time;
  String end_time;

  Timeline({this.word, this.start_time, this.end_time});


  factory Timeline.fromJson(Map<String, dynamic> json) {

    return Timeline(word: json['word'],
                start_time: json['start_time'],
                end_time: json['end_time']);
  }

  static List<Timeline> fromListOfMap(List<dynamic> data) {
    List<Timeline> lists = List<Timeline>();

    if (data is List) {
      data.forEach((element) {
        lists.add(Timeline.fromJson(element));
      });
    }

    return lists;
  }

}




  // {
  //     "id": "string",
  //     "video_src": "string",
  //     "video_qut": "string",
  //     "audio_src": "string",
  //     "audio_qut": "string",
  //     "text_src": {
  //       "title": "string",
  //       "text": "string"
  //     },
  //     "text_qut": {
  //       "title": "string",
  //       "text": "string"
  //     },
  //     "dictionary_items": [
  //       {
  //         "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  //         "key": "string",
  //         "value": "string",
  //         "sort": 0
  //       }
  //     ],
  //     "favorite": true,
  //     "reaction": 0,
  //     "name": "string",
  //     "timeline_src": [
  //       [
  //         {
  //           "word": "string",
  //           "start_time": "string",
  //           "end_time": "string"
  //         }
  //       ]
  //     ],
  //     "timeline_qut": [
  //       {
  //         "word": "string",
  //         "start_time": "string",
  //         "end_time": "string"
  //       }
  //     ],
  //     "subtitls": [
  //       "string"
  //     ]
  //   }
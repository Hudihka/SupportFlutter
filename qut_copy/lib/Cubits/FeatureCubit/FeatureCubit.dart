import 'package:qut/imports.dart';

part 'FeatureState.dart';

class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit()
      : super(FeatureState(
          isLoading: false,
          error: '',
          search: '',
          addByUser: FeaturedSection.empty(),
          continueWatching: FeaturedSection.empty(),
          items: [],
        ));

  load() {
    emit(state.copyWith(isLoading: true, error: '', search: ''));

    final request = GetFeatureRequest(search: null);

    request.load();

    request.endRequestJson = onEndRequest;
  }

  onEndRequest({dynamic obj, QUTError error}) async {
    if (error == null) {
      if (obj is GetFeatureRequestResponse) {
        emit(state.copyWith(
          isLoading: false,
          error: '',
          continueWatching: obj.continueWatching,
          addByUser: obj.addByUser,
          items: obj.favourite,
        ));
        return;
      }
    }

    emit(state.copyWith(isLoading: false, error: error));
  }
}

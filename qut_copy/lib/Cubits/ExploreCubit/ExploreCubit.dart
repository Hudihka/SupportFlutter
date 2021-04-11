import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qut/API/Base/BaseRequest.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/API/GetExploreRequest.dart';

part 'ExploreState.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit()
      : super(ExploreState(
          isLoading: false,
          error: '',
          items: [],
          search: '',
        ));

  load() async {
    emit(state.copyWith(isLoading: true, error: '', search: ''));

    final request = GetExploreRequest(search: null);

    request.load();

    request.endRequestJson = onEndRequest;
  }

  search(String text) async {
    emit(state.copyWith(isLoading: true, error: '', search: text));

    final request = GetExploreRequest(search: text);

    request.load();

    request.endRequestJson = onEndRequest;
  }

   onEndRequest({dynamic obj, QUTError error}) async {
    if (error == null) {
      if (obj is List<GetExploreRequestData>) {
        emit(state.copyWith(
          isLoading: false,
          error: '',
          items: obj,
        ));
        return;
      }
    }

    emit(state.copyWith(isLoading: false, error: error));
  }
}

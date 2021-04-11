import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qut/Models/Content.dart';

import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';



class ProfileState {
  // Widget content;

  bool loadStatus;
  QUTError error;

  bool isAutoriz;

  ProfileState({this.loadStatus, this.error, this.isAutoriz});

  ProfileState copyWith({bool newLoadStatus, QUTError newError, bool newIsAutoriz}) {

    if (newLoadStatus != null){
      this.loadStatus = newLoadStatus;
    }

    if (newIsAutoriz != null){
      this.isAutoriz = newIsAutoriz;
    }


    this.error = newError;

    return ProfileState(
        loadStatus: newLoadStatus ?? this.loadStatus,
        isAutoriz: newIsAutoriz ?? this.isAutoriz,
        error: this.error,
      );
  }
}

class ProfileCubit extends Cubit<ProfileState> {

  bool _loadStaus;

  final ProfileState contentState;

  ProfileCubit(this.contentState) : super(ProfileState());

  fetchContent() async {
    emit(contentState.copyWith(newLoadStatus: true));

    final isAutoriz = await DefaultUtils.shared.autorizUser;

    Timer.periodic(Duration(seconds: 1), (timer) {
      emit(contentState.copyWith(newLoadStatus: false, newIsAutoriz: isAutoriz));
     });

  }



}
 
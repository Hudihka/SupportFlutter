import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_cash_present/API/UserProvider.dart';
import 'package:load_cash_present/Data/DBProvider.dart';
import 'package:load_cash_present/Models/User.dart';

class UserState {
  final bool loadStatus;
  final List<User> listUsers;

  UserState({this.loadStatus, this.listUsers});

  UserState copyWith({bool loadStatus, List<User> listUsers}){

    return UserState(loadStatus: loadStatus ?? this.loadStatus,
                     listUsers: listUsers ?? this.listUsers);

  }
  
}


class UserCubit extends Cubit<UserState>{
  
  UserProvider _userProvider = UserProvider();
  List<User> _listUser = [];
  final DBProvider _cash = DBProvider.db;

  final UserState userState;
  UserCubit(this.userState) : super(UserState());

  Future<void> fetchUser() async {
    //показываем в начале пустой экран
    emit(userState.copyWith(listUsers: _listUser, loadStatus: true));

    //грузим юзеров из памяти
    _listUser = await _cash.getAllUsers();
    emit(userState.copyWith(listUsers: _listUser, loadStatus: true));

    try {
      // загружаем юзеров и показываем уже из памяти

      await _userProvider.getUser();
      _listUser = await _cash.getAllUsers();
      emit(userState.copyWith(listUsers: _listUser, loadStatus: false));

    } catch(_) {
      emit(userState.copyWith(listUsers: _listUser, loadStatus: false));
    }
  }

  Future<void> reloadUser() async {
    try {
      await _userProvider.getUser();
      _listUser = await _cash.getAllUsers();
      emit(userState.copyWith(listUsers: _listUser, loadStatus: false));
    } catch(_) {
      emit(userState.copyWith(listUsers: _listUser, loadStatus: false));
    }
  }


}



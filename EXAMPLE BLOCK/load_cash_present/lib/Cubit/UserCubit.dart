import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_cash_present/Models/User.dart';
import 'package:load_cash_present/Repository/UsersRepository.dart';


abstract class UserState {}

//список пустой
class UserEmptyState extends UserState {}

//список загрузки
class UserLoadState extends UserState {}

//список узеры загружены
class UserLoadedState extends UserState {
  List<dynamic> loadedUser;
  //@required обязателен для передачи
  // assert это обяз условие без которого не начнетсы выполнение
  UserLoadedState({@required this.loadedUser}) : assert(loadedUser != null);
}

//когда произошла ошибка при загрузке
class UserErrorState extends UserState {}


class UserCubit extends Cubit<UserState>{
  final UsersRepository usersRepository;
  UserCubit(this.usersRepository) : super(UserEmptyState());

//   async дает вам Future
// async* дает вам Stream.
// при async* есть yield

  Future<void> fetchUser() async {
    emit(UserEmptyState());
    try {
      emit(UserLoadState());
      //await позволяет дождаться выполнения асинхронной функции 
      //и после обработать результат, если он есть.
      final List<User> _loadedUserList = await usersRepository.getAllUsers();
      emit(UserLoadedState(loadedUser: _loadedUserList));
    } catch(_) {
      emit(UserEmptyState());
    }
  }

  Future<void> clearUser() async {
    emit(UserEmptyState());
  }
}

class UserLoadingState {
}


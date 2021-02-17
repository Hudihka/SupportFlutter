import 'package:flutter/material.dart';

abstract class ClientState {}

//список пустой
class ClientEmptyState extends ClientState {}

//список загрузки
class ClientLoadState extends ClientState {}

//список узеры загружены
class UserLoadedState extends ClientState {
  List<dynamic> loadedUser;
  //@required обязателен для передачи
  // assert это обяз условие без которого не начнетсы выполнение
  UserLoadedState({@required this.loadedUser}) : assert(loadedUser != null);
}

//когда произошла ошибка при загрузке
class ClientErrorState extends ClientState {}
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:load_and_cash_users/Models/Client.dart';

abstract class ClientState {}

//список пустой
class ClientEmptyState extends ClientState {}

//список загрузки
class ClientLoadState extends ClientState {}

//список узеры загружены
class ClientLoadedState extends ClientState {
  List<dynamic> loadedClient;
  //@required обязателен для передачи
  // assert это обяз условие без которого не начнетсы выполнение
  ClientLoadedState({@required this.loadedClient}) : assert(loadedClient != null);

  List<Client> get loadedUser {
    return loadedClient as List<Client>;
  }
}

//когда произошла ошибка при загрузке
class ClientErrorState extends ClientState {}
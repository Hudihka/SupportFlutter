

import 'package:load_and_cash_users/API/API.dart';
import 'package:load_and_cash_users/Bloc/ClientEvent.dart';
import 'package:load_and_cash_users/Bloc/ClientState.dart';
import 'package:load_and_cash_users/Models/Client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//   async дает вам Future
// async* дает вам Stream.
// при async* есть yield
//emit испускаю

class UserCubit extends Cubit<ClientState>{
  final ClientProvider clientProvider;

  UserCubit(this.clientProvider) : super(ClientEmptyState());

//   async дает вам Future
// async* дает вам Stream.
// при async* есть yield

  Future<void> fetchUser() async {
    emit(ClientEmptyState());
    try {
      emit(ClientLoadState());
      //await позволяет дождаться выполнения асинхронной функции 
      //и после обработать результат, если он есть.
      final List<Client> _loadedUserList = await clientProvider.getUser();
      emit(UserLoadedState(loadedUser: _loadedUserList));
    } catch(_) {
      emit(ClientEmptyState());
    }
  }
}


import 'package:load_and_cash_users/API/API.dart';
import 'package:load_and_cash_users/Bloc/ClientState.dart';
import 'package:load_and_cash_users/Models/Client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//   async дает вам Future
// async* дает вам Stream.
// при async* есть yield
//emit испускаю

class ClientCubit extends Cubit<ClientState>{
  final ClientProvider clientProvider;

  ClientCubit(this.clientProvider) : super(ClientEmptyState());

//   async дает вам Future
// async* дает вам Stream.
// при async* есть yield

  Future<void> fetchUser() async {
    emit(ClientEmptyState());
    try {
      emit(ClientLoadState());
      //await позволяет дождаться выполнения асинхронной функции 
      //и после обработать результат, если он есть.
      final List<Client> loadedList = await clientProvider.getUser();
      
      emit(ClientLoadedState(loadedClient: loadedList));
    } catch(_) {
      emit(ClientEmptyState());
    }
  }
}
// import 'package:load_and_cash_users/API/API.dart';
// import 'package:load_and_cash_users/Bloc/ClientState.dart';
// import 'package:load_and_cash_users/Data/DBProvider.dart';
// import 'package:load_and_cash_users/Models/Client.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// //   async дает вам Future
// // async* дает вам Stream.
// // при async* есть yield
// //emit испускаю

// class ClientCubit extends Cubit<ClientState> {

//   ClientCubit(ClientState state) : super(state);



// //   async дает вам Future
// // async* дает вам Stream.
// // при async* есть yield

//   Future<void> fetchClient() async {
//     try {
//       //начинаем загрузку
//       emit(ClientLoadState());
//       //загружаем
//       final provider = ClientProvider();
//       await provider.getUser();
//       await casheClient();
//     } catch (_) {
//       emit(ClientErrorState());
//     }
//   }

//   //закешированные обьекты
//   casheClient() async {
//     print('-------+++++++-----------');
//     List<Client> cashe = await DBProvider.db.getAllClients();
//     print('----111111111---------');
//     emit(ClientGetFromCashe(casheClient: cashe));
//   }

// }

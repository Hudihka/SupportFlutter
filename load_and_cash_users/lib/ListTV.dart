import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_and_cash_users/API/API.dart';
import 'package:load_and_cash_users/Bloc/ClientCubit.dart';
import 'package:load_and_cash_users/Models/Client.dart';

import 'Bloc/ClientState.dart';

class ListTV extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListTVState();
  }
}

class _ListTVState extends State<ListTV> {
  final usersRepository = ClientProvider();
  List<Client> _dataArray = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientCubit>(
      create: (context) => ClientCubit(usersRepository),
      child: Scaffold(
        appBar: AppBar(
          title: Text('TV Application'),
        ),
        body: Container(
          child: _table(),
        ),
      ),
    );
  }

  Widget _table(){
    return BlocBuilder<ClientCubit, ClientState>(
              builder: (context, state) {

      if (state is ClientEmptyState) {
        return Center(
          child: Text(
            'No data received. Press Button load',
            style: TextStyle(fontSize: 20),
          ),
        );
      } else if (state is ClientLoadState) {

        return Center(
          child: CircularProgressIndicator(),
        );

      } else if (state is ClientLoadedState) {
        _dataArray = state.loadedUser;

        return ListView.builder(
              itemCount: _dataArray.length,
              itemBuilder: (BuildContext context, int position) {
                return _cellForIndex(position);
        });

      } else { //ошибка
        return Center(
          child: Text(
            'Error fetching users', 
            style: TextStyle(fontSize: 20)
            ),
        );
      }       
    });
  }


  Widget _cellForIndex(int index) {
    //ячейка по индексу
    Client obj = _dataArray[index];

    return Ink(
      color: Colors.grey[50], //выделение ячейки
      child: ListTile(
        subtitle: Text(obj.username),
        title: Text(obj.name),
        leading: CircleAvatar(
          child: Text(obj.id.toString()),
        ),
        trailing: Text(obj.email),
        onTap: () {
          print('-------------------------');
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load_and_cash_users/API/API.dart';
import 'package:load_and_cash_users/Data/DBProvider.dart';
import 'package:load_and_cash_users/Models/Client.dart';


class ListTV extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListTVState();
  }
}

class _ListTVState extends State<ListTV> {
  List<Client> _dataArray = [];

  final ClientProvider _request = ClientProvider();
  var _loadStatus = false;
  final _dataBase = DBProvider.db;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TV Application'),
        ),
        body: _buildEmployeeListView(),
      );
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: _dataBase.getAllClients(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        _loadStatus = false;

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _crerateList(snapshot.data as List<Client>);
        }
      },
    );
  }


  RefreshIndicator _crerateList(List<Client> dataArray){
        _dataArray = dataArray;

        return RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder(
              itemCount: _dataArray.length,
              itemBuilder: (BuildContext context, int position) {
                return _cellForIndex(position);
        }),
        );
  }

  Future<void> _getData() async {
    _loadUsers();
  }

  _loadUsers() async {
    if (_loadStatus == false){
      _loadStatus = true;
      await _request.getUser();

    setState(() {
       _loadStatus = false;
    });
    }
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

import 'package:flutter/material.dart';
import 'package:load_and_cash_users/Models/Client.dart';

class ListTV extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListTVState();
  }
}

class _ListTVState extends State<ListTV> {
  List<Client> _data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Application'),
      ),
      body: Container(

        child: ListView.builder( //это динамически меняющ таблица те если много ячеек
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int position) {
            return _cellForIndex(position);
          }),
      ),
    );
  }

  Widget _cellForIndex(int index){ //ячейка по индексу
    Client obj = _data[index];

    return Ink(
            color: Colors.grey[50], //выделение ячейки
            child: ListTile(
              subtitle: Text(obj.username),
              title: Text(obj.name),
              leading: CircleAvatar(
                child: Text(obj.id.toString()),
              ),
              trailing: Text(obj.email),
              onTap: (){
                print('-------------------------');
              },
            ),
          );
  }
}

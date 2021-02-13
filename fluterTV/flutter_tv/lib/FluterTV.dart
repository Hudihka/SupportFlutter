import 'package:flutter/material.dart';
import 'package:flutter_tv/Data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListTV extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListTVState();
  }
}

class ListTVState extends State<ListTV> {
  List<DataTV> _data = [];

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
        
        
        
        // ListView( //это простая таблица
        //   //таблица
        //   children: _buildList(), //ячейки

        // ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  Widget _cellForIndex(int index){ //ячейка по индексу
    DataTV obj = _data[index];
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
                print('---------${obj.name} - ${obj.username}----------------');
              },
            ),
          );
  }

  void _loadCC() async {
    //await значит выполняется на другом потоке
    final response =
        await http.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      var tagObjsJson = jsonDecode(response.body) as List;
      List<DataTV> datasObjs =
          tagObjsJson.map((tagJson) => DataTV.fromJson(tagJson)).toList();
      _data = datasObjs;
      setState(() {}); //по сути релоад дата

    }
  }
}

import 'package:flutter/material.dart';
import 'package:qut/Views/Cells/CellTag.dart';

class ListTagsInCell extends StatelessWidget {
  
  List<String> dataArray;
  Color colorBorder;
  Color colorText;
  Color colorBacground;

  ListTagsInCell(this.dataArray, this.colorBorder, this.colorText, this.colorBacground);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: dataArray.length,
        itemBuilder: (context, index) {
          String obj = dataArray[index];
          return CellTag(obj, colorBorder, colorText, colorBacground);
          // return _cellTag(obj);
        });
  }
}


import 'package:qut/Models/Dictionary.dart';
import 'package:qut/Models/Timeline.dart';
import 'package:qut/AppIcons.dart';

enum EnumTupeCell{
  content,
  empty,
  tags,
  registration,
  load
}

enum EnumContentTupeCell{
  video,
  audio,
  text 
}

extension TextIndex on EnumContentTupeCell {

  String get backendParametr {
    switch(this) {
      case EnumContentTupeCell.video: return "video";
      case EnumContentTupeCell.audio: return "audio";
      case EnumContentTupeCell.text: return "text";
    }
  }

  String get nameIcon {
    switch(this) {
      case EnumContentTupeCell.video: return AppIcons.video;
      case EnumContentTupeCell.audio: return AppIcons.audio;
      case EnumContentTupeCell.text: return AppIcons.text;
    }
  }

  //МЕТОДЫ ДЛЯ ШТОРКИ ТЕГИ

  String get textCell {
    switch(this) {
      case EnumContentTupeCell.video: return "Watch";
      case EnumContentTupeCell.audio: return "Listen";
      case EnumContentTupeCell.text: return "Read";
    }
  }


  String get nameIconCellNotSelected {
    switch(this) {
      case EnumContentTupeCell.video: return "assets/icons/CellContent/cellVideoNoSelected.png";
      case EnumContentTupeCell.audio: return "assets/icons/CellContent/cellAudioNoSelected.png";
      case EnumContentTupeCell.text: return "assets/icons/CellContent/cellBookNoSelected.png";
    }
  }

  String get nameIconCellSelected {
    switch(this) {
      case EnumContentTupeCell.video: return "assets/icons/CellContent/cellVideoSelected.png";
      case EnumContentTupeCell.audio: return "assets/icons/CellContent/cellAudioSelected.png";
      case EnumContentTupeCell.text: return "assets/icons/CellContent/cellBookSelected.png";
    }
  }


}

class Content {

  EnumTupeCell typeCell;
  EnumContentTupeCell type;  //тип контента

  String id;
  bool added_by_user;
  String content_link;
  String content_preview;

  int content_qut_duration;
  String text_qut;
  List<Dictionary> category = [];


  bool favorite = false;
  int reaction = 0;
  String name;

  

  Content({this.typeCell,
           this.type,
           this.id,
           this.added_by_user,
           this.content_link,
           this.content_preview,
           this.content_qut_duration,

           this.text_qut,
           this.category,

           this.favorite,
           this.reaction,
           this.name}){
            
            switch (typeCell) {
              case EnumTupeCell.content:
                break;
              case EnumTupeCell.empty:
                this.id = '0';
                break;
              case EnumTupeCell.registration:
                this.id = '1';
                break;
              case EnumTupeCell.tags:
                this.id = '2';
                break;
              case EnumTupeCell.load:
                this.id = '3';
                break;
            }


           }

  factory Content.fromJson(Map<String, dynamic> json) {


    List<dynamic> jsonCategoryItems = json['category'];
    List<Dictionary> categoryItems = Dictionary.fromListOfMap(jsonCategoryItems);


    EnumContentTupeCell type = EnumContentTupeCell.video;

    String typeContent = json['type'];
    if (typeContent != null){
      if (typeContent == "audio"){
        type = EnumContentTupeCell.audio;
      } else if (typeContent == "text"){
        type = EnumContentTupeCell.text;
      }
    }


    return  Content(typeCell: EnumTupeCell.content,
           id: json['id'],
           type: type,
           added_by_user: json['added_by_user'] ?? false,
           content_link: json['content_link'],
           content_preview: json['content_preview'],
           content_qut_duration: json['content_qut_duration'] ?? 0,
           text_qut: json['text_qut'] ?? "",
           category: categoryItems,
           favorite: json['favorite'] ?? false,
           reaction: json['reaction'],
           name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> param = {};
    param['id'] = id;
    param['content_link'] = content_link;
    param['content_preview'] = content_preview;
    param['content_qut_duration'] = content_qut_duration;
    param['name'] = name;

    return param;
  }

  static List<Content> fromListOfMap(List<dynamic> data) {
    List<Content> wordLists = List<Content>();

    if (data is List) {
      data.forEach((element) {
        wordLists.add(Content.fromJson(element));
      });
    }

    return wordLists;
  }


  List<String> get listCategory {
    List<String> list = category.map((e) => e.value).toList();

    return list;
  }

}

      
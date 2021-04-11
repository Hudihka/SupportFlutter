



import 'package:qut/Models/Content.dart';
import 'package:qut/Models/Dictionary.dart';

class TagsCurtainSingelton{

  TagsCurtainSingelton._();
  static final TagsCurtainSingelton shared = TagsCurtainSingelton._();

  EnumContentTupeCell _selectedType = null;
  List<Dictionary> _listSelectedDictionary = [];


  // _setSelectedType(EnumContentTupeCell type){
  //   _selectedType = type;
  // }
  
  EnumContentTupeCell get getSelectedType {
    return _selectedType;
  }

  removeOldDictionary(List<Dictionary> list){ //удаляем то, что не пришло
    if (_listSelectedDictionary.isEmpty){
      return;
    }

    _listSelectedDictionary.where((element) => list.contains(element));
  }

  // _setListDictionary(List<Dictionary> list){
  //   _listSelectedDictionary = list;
  // }
  
  List<Dictionary> get getListDictionary {
    return _listSelectedDictionary;
  }

  _clearAll(){
    _selectedType = null;
    _listSelectedDictionary = [];
  }

   setNewContent(EnumContentTupeCell type, List<Dictionary> list){
    _clearAll();
    _selectedType = type;
    _listSelectedDictionary = list;
  }

  setNewSelectedDictionary(List<Dictionary> list){
    _listSelectedDictionary = list;
  }


}
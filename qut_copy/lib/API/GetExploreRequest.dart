import 'package:qut/imports.dart';

class GetExploreRequestData {
  final Category category;
  final List<Content> contents;

  GetExploreRequestData({@required this.category, @required this.contents});

  factory GetExploreRequestData.fromJson(Map json) {
    return GetExploreRequestData(
      category: Category.fromJson(json['category']),
      contents:  Content.fromListOfMap(json['contents']),
    );
  }

  static List<GetExploreRequestData> listFromJson(List json) {
    if (json is List) {
      return json.map((e) => GetExploreRequestData.fromJson(e)).toList();
    }
    return [];
  }
}

class GetExploreRequest extends BaseRequest {
  String search;

  EnumContentTupeCell type;

  @override
  String get strUrl {
    return "explore/";
  }

  GetExploreRequest({
    this.search,
  });

  //для теста используй demo/demo

  @override
  Map<String, dynamic> parametrs() {
    Map<String, dynamic> par = {};

    if (search != null) {
      par['search'] = search;
    }

    // // final list = TagsCurtain.selectedListItems;
    // final singlton = TagsCurtainSingelton.shared;
    // final list = singlton.getListDictionary;
    //
    // if (list.isNotEmpty){
    //   List<String> listStr = [];
    //   for (var i in list){
    //     listStr.add(i.id);
    //   }
    //
    //   par['dictionary_items[]'] = listStr;
    // }
    //
    // final typeStr = this.type.backendParametr ?? singlton.getSelectedType.backendParametr;
    //
    // if (typeStr != null) {
    //   par['type'] = typeStr;
    // }

    return par;
  }

  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {
    if (error != null) {
      endRequestJson(error: error);
    } else {

      final res = GetExploreRequestData.listFromJson(json['data']);

      endRequestJson(obj: res, error: error);
    }
  }
}

import 'package:qut/imports.dart';

class GetFeatureRequestResponse {
  final FeaturedSection addByUser;
  final FeaturedSection continueWatching;
  final List<GetExploreRequestData> favourite;

  GetFeatureRequestResponse({
    @required this.addByUser,
    @required this.continueWatching,
    @required this.favourite,
  });

  GetFeatureRequestResponse copyWith({
    FeaturedSection addByUser,
    FeaturedSection continueWatching,
    List<GetExploreRequestData> favourite,
  }) =>
      GetFeatureRequestResponse(
        addByUser: addByUser ?? this.addByUser,
        continueWatching: continueWatching ?? this.continueWatching,
        favourite: favourite ?? this.favourite,
      );

  Map<String, dynamic> toMap() =>
      {"addByUser": addByUser, "continueWatching": continueWatching, "favourite": favourite};

  Map<String, dynamic> toJson() =>
      {"addByUser": addByUser, "continueWatching": continueWatching, "favourite": favourite};

  static GetFeatureRequestResponse fromJson(Map<String, dynamic> json) => GetFeatureRequestResponse(
        addByUser: FeaturedSection.fromJson(json['addByUser']),
        continueWatching: FeaturedSection.fromJson(json['continueWatching']),
        favourite: GetExploreRequestData.listFromJson(json['favourite']['data']),
      );

  String toString() =>
      "GetFeatureRequestResponse[addByUser=$addByUser,continueWatching=$continueWatching,favourite=$favourite]";
}

class GetFeatureRequest extends BaseRequest {
  String search;

  EnumContentTupeCell type;

  @override
  String get strUrl {
    return "featured/";
  }

  GetFeatureRequest({
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
      final res = GetFeatureRequestResponse.fromJson(json);

      endRequestJson(obj: res, error: error);
    }
  }
}

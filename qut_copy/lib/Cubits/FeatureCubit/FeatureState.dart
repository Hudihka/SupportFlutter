part of 'FeatureCubit.dart';

class FeatureState {
  final bool isLoading;
  var error;
  final String search;
  final FeaturedSection addByUser;
  final FeaturedSection continueWatching;
  final List<GetExploreRequestData> items;

  FeatureState({
    @required this.isLoading,
    @required this.error,
    @required this.search,
    @required this.addByUser,
    @required this.continueWatching,
    @required this.items,
  });

  FeatureState copyWith({
    bool isLoading,
    var error,
    String search,
    FeaturedSection addByUser,
    FeaturedSection continueWatching,
    List<GetExploreRequestData> items,
  }) =>
      FeatureState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        search: search ?? this.search,
        addByUser: addByUser ?? this.addByUser,
        continueWatching: continueWatching ?? this.continueWatching,
        items: items ?? this.items,
      );

  Map<String, dynamic> toMap() => {
        "isLoading": isLoading,
        "error": error,
        "search": search,
        "addByUser": addByUser,
        "continueWatching": continueWatching,
        "items": items
      };

  Map<String, dynamic> toJson() => {
        "isLoading": isLoading,
        "error": error,
        "search": search,
        "addByUser": addByUser,
        "continueWatching": continueWatching,
        "items": items
      };

  static FeatureState fromJson(Map<String, dynamic> json) => FeatureState(
        isLoading: json['isLoading'],
        error: json['error'],
        search: json['search'],
        addByUser: json['addByUser'],
        continueWatching: json['continueWatching'],
        items: json['items'],
      );

  String toString() =>
      "FeatureState[isLoading=$isLoading,error=$error,search=$search,addByUser=$addByUser,continueWatching=$continueWatching,items=$items]";
}

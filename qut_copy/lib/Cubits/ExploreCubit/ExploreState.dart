part of 'ExploreCubit.dart';

class ExploreState {
  final bool isLoading;
  var error;
  final List<GetExploreRequestData> items;
  final String search;

  ExploreState({
    @required this.isLoading,
    @required this.error,
    @required this.items,
    @required this.search,
  });

  ExploreState copyWith({
    bool isLoading,
    var error,
    List<GetExploreRequestData> items,
    String search,
  }) =>
      ExploreState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        items: items ?? this.items,
        search: search ?? this.search,
      );

  Map<String, dynamic> toMap() => {
        "isLoading": isLoading,
        "error": error,
        "items": items,
        "search": search
      };

  Map<String, dynamic> toJson() => {
        "isLoading": isLoading,
        "error": error,
        "items": items,
        "search": search
      };

  static ExploreState fromJson(Map<String, dynamic> json) => ExploreState(
        isLoading: json['isLoading'],
        error: json['error'],
        items: json['items'],
        search: json['search'],
      );

  String toString() =>
      "ExploreState[isLoading=$isLoading,error=$error,items=$items,search=$search]";
}

import 'package:qut/imports.dart';

class FeaturedSection {
  final List<Content> data;
  var meta;

  FeaturedSection({
    @required this.data,
    @required this.meta,
  });

  FeaturedSection copyWith({
    List<Content> data,
    var meta,
  }) =>
      FeaturedSection(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  Map<String, dynamic> toMap() => {"data": data, "meta": meta};

  Map<String, dynamic> toJson() => {"data": data, "meta": meta};

  static FeaturedSection fromJson(Map<String, dynamic> json) {
    if (json == null) return FeaturedSection.empty();
    return FeaturedSection(
      data: Content.fromListOfMap(json['data']),
      meta: json['meta'],
    );
  }

  String toString() => "FeaturedSection[data=$data,meta=$meta]";

  factory FeaturedSection.empty() {
    return FeaturedSection(data: [], meta: null);
  }
}

import 'package:qut/imports.dart';

class Category {
  final String id;
  final String name;
  final int total;

  Category({
    @required this.id,
    @required this.name,
    @required this.total,
  });

  factory Category.fromJson(Map json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      total: json['total'] ?? 0,
    );
  }

  factory Category.fromDictionary(Dictionary item) {
    return Category(
      id: item.id,
      name: item.value,
      total: 0,
    );
  }

  static listFromJson(List json) {
    if (json is List) {
      return json.map((e) => Category.fromJson(e));
    }
    return [];
  }


}


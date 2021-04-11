

class Dictionary {

  String id;
  String value;

  Dictionary({this.id, this.value});

  factory Dictionary.fromJson(Map<String, dynamic> json) {

    return Dictionary(id: json['id'],
                      value: json['value'] ?? "");
  }

  static List<Dictionary> fromListOfMap(List<dynamic> data) {
    List<Dictionary> lists = [];
    if (data is List) {
      data.forEach((element) {
        lists.add(Dictionary.fromJson(element));
      });
    }
    return lists;
  }

}
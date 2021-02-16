//подробней о декодировании джейсона здесь
//https://bezkoder.com/dart-flutter-parse-json-string-array-to-object-list/
class DataTV {
  String name;
  String username;
  int id;
  String email;

  DataTV(this.name, this.username, this.id, this.email);

  factory DataTV.fromJson(dynamic json) {
    return DataTV(
      json['name'] as String, 
      json['username'] as String,
      json['id'] as int,
      json['email'] as String
      );
  }

  //функция получения джейсона из модели
  //
  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.username}, ${this.id}, ${this.email} }';
  // }
}
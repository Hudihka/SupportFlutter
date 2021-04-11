
class QUTError{
  String error;
  String errorDescription;

  QUTError({this.error, this.errorDescription});

  factory QUTError.fromJson(Map<String, dynamic> json) {
    return QUTError(
      error: json['error'],
      errorDescription: json['error_description']
    );
  }
}
extension ExtensionDuration on Duration {


  int get countSeconds {
    List<String> strDuration = this.toString().split('.');

    if (strDuration.first == null) {
      return 0;
    }

    int hours = 0;
    int minutes = 0;
    int seconds = 0;

    List<String> parts = strDuration.first.split(':');

    if (parts.length == 3) {
      hours = int.parse(parts[0]);
      minutes = int.parse(parts[1]);
      seconds = int.parse(parts[2]);
    }

    if (parts.length == 2) {
      minutes = int.parse(parts[0]);
      seconds = int.parse(parts[1]);
    }

    if (parts.length == 1) {
      seconds = int.parse(parts[0]);
    }

    return hours * 3600 + minutes * 60 + seconds;
  }
}

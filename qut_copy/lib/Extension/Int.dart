
extension ExtensionString on int {
//
  String get durationContent {
    if (this == null){
      return "0:00";
    }

    if (this < 10){
      return '0:0$this';
    }

    if (this < 60){
      return '0:$this';
    }


    final int secondsOll = this % 60;

    var seconds = '$secondsOll';
    if (secondsOll < 10){
      seconds = '0$secondsOll';
    }

    final int hour = this ~/ 3600;

    final int min = (this - (hour * 3600) - secondsOll) ~/ 60;

    


    if (this > 3600){
      String minStr = '$min';
      if (min < 10){
        minStr = '0$min';
      }

      return '$hour:$minStr:$seconds';
    } else {
      return '$min:$seconds';
    }

    
  }


}
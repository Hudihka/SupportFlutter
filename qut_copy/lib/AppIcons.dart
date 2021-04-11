import 'package:qut/Models/Content.dart';

abstract class AppIcons {
  static const video = "assets/icons/IconType/videoIcon.png";
  static const audio = "assets/icons/IconType/audioIcon.png";
  static const text = "assets/icons/IconType/bookIcon.png";
  static const threePoint = "assets/icons/threePoint.png";
  static const search = "assets/icons/search.png";
  static const star = "assets/icons/Feature/Star.png";
  static const clock = "assets/icons/Feature/clock.png";
  static const heart = "assets/icons/Feature/heart.png";
  static const back = "assets/icons/Feature/heart.png";
}

abstract class AppIconTop {
  static const back = 'assets/icons/BBItem/BBItemBack.png';
}

abstract class AppImages {
  static const placeholder = "assets/images/Splash/splash.png";
}

getIconByType(EnumContentTupeCell typeCell) {
  switch(typeCell) {
    case EnumContentTupeCell.video:
      return AppIcons.video;
    case EnumContentTupeCell.audio:
      return AppIcons.audio;
    case EnumContentTupeCell.text:
      return AppIcons.text;
  }
}


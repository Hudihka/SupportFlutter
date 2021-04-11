import 'package:qut/imports.dart';

abstract class AppTextStyle {
  static const r11 = TextStyle(fontSize: 11, color: AppColors.darkGrey);
  static const sb11 = TextStyle(fontSize: 11, color: AppColors.darkGrey, fontWeight: FontWeight.w600);
  static const b11 = TextStyle(fontSize: 11, color: AppColors.darkGrey, fontWeight: FontWeight.bold);

  static const r12 = TextStyle(fontSize: 12, color: AppColors.darkGrey);
  static const b12 = TextStyle(fontSize: 12, color: AppColors.darkGrey);
  static const sb12 = TextStyle(fontSize: 12, color: AppColors.darkGrey, fontWeight: FontWeight.w600);

  static const r14 = TextStyle(fontSize: 14, color: AppColors.darkGrey);

  static const r16 = TextStyle(fontSize: 16, color: AppColors.darkGrey);
  static const b16 = TextStyle(fontSize: 16, color: AppColors.darkGrey, fontWeight: FontWeight.bold);

  static const b20 = TextStyle(fontSize: 20, color: AppColors.darkGrey, fontWeight: FontWeight.w600);

  static const b24 = TextStyle(fontSize: 24, color: AppColors.darkGrey, fontWeight: FontWeight.bold);

  static r11Color(Color color) => r11.copyWith(color: color);

  static r12Color(Color color) => r12.copyWith(color: color);
  static sb12Color(Color color) => sb12.copyWith(color: color);
  static b12Color(Color color) => b12.copyWith(color: color);

  static r14Color(Color color) => r14.copyWith(color: color);

  static r16Color(Color color) => r16.copyWith(color: color);
  static b16Color(Color color) => b16.copyWith(color: color);

  static b20Color(Color color) => b20.copyWith(color: color);

  static b24Color(Color color) => b24.copyWith(color: color);
}
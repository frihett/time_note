import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiStyle {
  static const Color primaryColor = Color(0xFF3EB489); // 민트
  static const Color primaryColorSurface = Color(0xFFE0F7EF); // 밝은 민트 배경
  static const Color secondaryColor = Color(0xFF2196F3); // 파랑
  static const Color secondaryColorSurface = Color(0xFFD9EFFF); // 소프트 블루 배경
  static const Color thirdColor = Color(0xFFE91E63); // 핑크
  static const Color thirdColorSurface = Color(0xFFFFE4E9); // 라이트 핑크 배경

  static const MaterialColor black = MaterialColor(0xff282828, color);
  static const Map<int, Color> color = {
    100: Color(0xffFFFFFF),
    200: Color(0xffe2e8f0),
    500: Color(0xffF5F5F5),
    600: Color(0xffE9E9E9),
    700: Color(0xff828282),
    800: Color(0xff424242),
    900: Color(0xff282828),
  };

  static TextStyle h1Style = TextStyle(
      fontSize: 24.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');
  static TextStyle h2Style = TextStyle(
      fontSize: 20.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');
  static TextStyle h3Style = TextStyle(
      fontSize: 18.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');
  static TextStyle h4Style = TextStyle(
      fontSize: 16.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');
  static TextStyle bodyStyle = TextStyle(
      fontSize: 14.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');
  static TextStyle smallStyle = TextStyle(
      fontSize: 12.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');
  static TextStyle extraSmallStyle = TextStyle(
      fontSize: 10.sp,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF282828),
      fontFamily: 'Inter');

  static const FontWeight regularFont = FontWeight.w400;
  static const FontWeight semiBoldFont = FontWeight.w600;
}
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiStyle {
  static const Color primaryColor = Color(0xFF8687E7);
  static const Color primaryColorSurface = Color(0xFFE5E5F8);
  static const Color secondaryColor = Color(0xFF6C79E0);
  static const Color secondaryColorSurface = Color(0xFFD9E0F8);
  static const Color thirdColor = Color(0xFFE67C9A);
  static const Color thirdColorSurface = Color(0xFFF8E3EB);

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class Themes {

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.blue,
    focusColor: AppColors.blue,
    backgroundColor: AppColors.greyBg,
    shadowColor: AppColors.greyText,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),

    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.blue,
        selectionHandleColor: AppColors.blue,
        selectionColor: AppColors.blue
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'SF Pro Display',
        color: AppColors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        fontFamily: 'SF Pro Display',
        color: AppColors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
      headline3: TextStyle(
        fontFamily: 'SF Pro Display',
        color: AppColors.greyText,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        fontFamily: 'SF Pro Display',
        color: AppColors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w400,
      ),

      subtitle1: TextStyle(
        fontFamily: 'SF Pro Text',
        color: AppColors.green,
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
      ),

      bodyText1: TextStyle(
        fontFamily: 'SF Pro Text',
        color: AppColors.black,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        fontFamily: 'SF Pro Text',
        color: AppColors.greyText,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
      ),
    ),
  );


  ///
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'SF Pro Display',
    scaffoldBackgroundColor: AppColors.black,
    backgroundColor: AppColors.black,
    primaryColor: AppColors.black,
    focusColor: AppColors.blue,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );

}



import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles{
  static headline1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle:
          TextStyle(fontSize: 80.0, fontWeight: wFont, color: txtColor));

  static headline2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle:
          TextStyle(fontSize: 60.0, fontWeight: wFont, color: txtColor));

  static headline3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle:
          TextStyle(fontSize: 40.0, fontWeight: wFont, color: txtColor));

  static headline4(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 34.0,
              fontWeight: wFont,
              letterSpacing: 0.0025,
              color: txtColor));

  static headline5(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle:
          TextStyle(fontSize: 24.0, fontWeight: wFont, color: txtColor));

  static headline6(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: wFont,
              letterSpacing: 0.0075,
              color: txtColor));

  //#endregion

  //#region Subtitle
  static subtitle1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: wFont,
              letterSpacing: 0.05,
              color: txtColor));

  static subtitle2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.05,
              color: txtColor));

  static subtitle3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.05,
              color: txtColor));

  //#endregion

  //#region Body
  static body1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: wFont,
              letterSpacing: 0.05,
              color: txtColor));

  static body2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.15,
              color: txtColor));

  static body3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.15,
              color: txtColor));

  //#endregion

  //#region Button
  static button1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.013,
              color: AppColors.primary));

  static button2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.15,
              color: txtColor));

  static button3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.15,
              color: txtColor));

  //#endregion

  //#region Caption
  static captionRF1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: wFont,
              letterSpacing: 0.03,
              color: txtColor));

  static captionRF2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.03,
              color: txtColor));

  static captionRF3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 12,
              fontWeight: wFont,
              letterSpacing: 0.03,
              color: txtColor));

  static captionRF4(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle:
          TextStyle(fontSize: 10, fontWeight: wFont, color: txtColor));

  //#endregion

  //#region Overlie
  static overlieRF1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.15,
              color: txtColor));

  static overlieRF2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 12,
              fontWeight: wFont,
              letterSpacing: 0.10,
              color: txtColor));

  static overlieRF3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 12,
              fontWeight: wFont,
              letterSpacing: 0.10,
              color: txtColor));

  static overlieRF4(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 10,
              fontWeight: wFont,
              letterSpacing: 0.05,
              color: txtColor));

//#endregion

  //#region Review
  static review(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500}) =>
      GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 6,
              fontWeight: wFont,
              letterSpacing: 0.01,
              color: txtColor));

  static reviewPara(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.inter(
          textStyle:
          TextStyle(fontSize: 8, fontWeight: wFont, color: txtColor));

  //#endregion
//#endregion

//#region ==Oxygen Font==
  //#region Caption
  static captionOF1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: wFont,
              letterSpacing: 0.03,
              color: txtColor));

  static captionOF2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700}) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: wFont,
              letterSpacing: 0.03,
              color: txtColor));

  static captionOF3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: 12,
              fontWeight: wFont,
              letterSpacing: 0.03,
              color: txtColor));

  static captionOF4(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400}) =>
      GoogleFonts.oxygen(
          textStyle:
          TextStyle(fontSize: 10, fontWeight: wFont, color: txtColor));

  //#endregion

  //#region Overlie
  static overlieOF1(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400,
        double sFont = 14}) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: sFont,
              fontWeight: wFont,
              letterSpacing: 0.15,
              color: txtColor));

  static overlieOF2(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w400,
        double sFont = 12}) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: sFont,
              fontWeight: wFont,
              letterSpacing: 0.10,
              color: txtColor));

  static overlieOF3(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w700,
        double sFont = 12}) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: sFont,
              fontWeight: wFont,
              letterSpacing: 0.10,
              color: txtColor));

  static overlieOF4(
      {Color txtColor = AppColors.greyDark,
        FontWeight wFont = FontWeight.w500,
        double sFont = 10
      }) =>
      GoogleFonts.oxygen(
          textStyle: TextStyle(
              fontSize: sFont,
              fontWeight: wFont,
              letterSpacing: 0.05,
              color: txtColor));
//#endregion
//#endregion

}
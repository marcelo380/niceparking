import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_parking/utils/consts.dart';

class CustomTypography {
  static Text title28(
    String content, {
    Color color = Colors.white,
    TextOverflow overFlow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.left,
  }) =>
      _makeTextComponent(
        content,
        28.0,
        FontWeight.w700,
        color: color,
        overFlow: overFlow,
        align: textAlign,
      );

  static Text title20(
    String content, {
    Color color = Colors.white,
    TextOverflow overFlow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.left,
  }) =>
      _makeTextComponent(
        content,
        20.0,
        FontWeight.w700,
        color: color,
        overFlow: overFlow,
        align: textAlign,
      );

  static Text title16(
    String content, {
    Color color = Colors.white,
    TextOverflow overFlow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.left,
  }) =>
      _makeTextComponent(
        content,
        16.0,
        FontWeight.w700,
        color: color,
        overFlow: overFlow,
        align: textAlign,
      );

  static Text title14(
    String content, {
    Color color = Colors.white,
    TextOverflow overFlow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.left,
  }) =>
      _makeTextComponent(
        content,
        14.0,
        FontWeight.w700,
        color: color,
        overFlow: overFlow,
        align: textAlign,
      );

  static Text body14(
    String content, {
    Color color = Colors.white,
    TextOverflow overFlow = TextOverflow.ellipsis,
    TextAlign textAlign = TextAlign.left,
  }) =>
      _makeTextComponent(
        content,
        14.0,
        FontWeight.w400,
        color: color,
        overFlow: overFlow,
        align: textAlign,
      );

  ///base para criação das tipografias
  static Text _makeTextComponent(
    String content,
    double size,
    FontWeight fontWeight, {
    Color? color,
    TextOverflow? overFlow,
    TextAlign? align,
  }) {
    return Text(
      content,
      style: GoogleFonts.lato(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: overFlow,
      textAlign: align,
    );
  }
}

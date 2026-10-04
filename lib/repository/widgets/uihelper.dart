import 'package:flutter/material.dart';

class UiHelper {
  static Widget CustomImage({
    required String img,
    double? width,
    double? height,
  }) {
    return Image.asset(
      "assets/images/$img",
      width: width ?? 200, // Default to 200 if no width is provided
      height: height ?? 200, // Default to 200 if no height is provided
    );
  }

  static Widget CustomText({
    required String text,
    Color? color,
    double? fontsize,
    FontWeight? fontweight,
    String? fontfamily,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontweight,
        fontFamily: fontfamily,
      ),
    );
  }
}

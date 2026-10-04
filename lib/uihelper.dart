import 'package:flutter/material.dart';

class UiHelper {
  static Widget CustomImage({required String img}) {
    return Image.asset(
      "assets/images/$img",
      width: 250,
      height: 250,
      fit: BoxFit.contain,
    );
  }
}
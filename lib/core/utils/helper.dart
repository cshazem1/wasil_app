import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CustomSnackBar {
  static void show(
      BuildContext context,
      String message, {
        Color backgroundColor = AppColors.primary,
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}

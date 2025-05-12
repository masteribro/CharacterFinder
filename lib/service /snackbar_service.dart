import 'package:flutter/material.dart';

class SnackbarService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    _showSnackbar(message, Colors.red);
  }

  static void showSuccess(String message) {
    _showSnackbar(message, Colors.green);
  }

  static void showInfo(String message) {
    _showSnackbar(message, Colors.blueGrey);
  }

  static void _showSnackbar(String message, Color backgroundColor) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

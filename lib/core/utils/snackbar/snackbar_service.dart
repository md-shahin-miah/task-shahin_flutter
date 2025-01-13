import 'package:flutter/material.dart';

class SnackbarService {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar({required title, required backgroundColor}) {
    return scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(content: Text(title), backgroundColor: backgroundColor));
  }
}

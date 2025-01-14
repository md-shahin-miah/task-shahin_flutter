import 'package:flutter/material.dart';

class SnackBarService {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar({required title, required backgroundColor}) {
    return scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(title), backgroundColor: backgroundColor));
  }
}

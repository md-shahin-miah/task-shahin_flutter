import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class SnackBarService {
//   static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
//
//   static showSnackBar({required title, required backgroundColor}) {
//     return scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(title), backgroundColor: backgroundColor));
//   }
// }


class ToastService {


  static showToast({required title, required backgroundColor}) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}


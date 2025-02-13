import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



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


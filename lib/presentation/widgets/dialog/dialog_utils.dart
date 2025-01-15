import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Dialog loaderDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),

  //this right here
  child: Container(
    height: 120.0,
    width: 80.0,
    color: Colors.white,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: SpinKitCircle(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        Spacer(),
      ],
    ),
  ),
);
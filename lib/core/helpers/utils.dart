
import 'dart:math';
import 'package:shahin_appify_task/config/themes/styles/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/snackbar/snackbar_service.dart';

class Utils{
  static  String getCustomUniqueId() {
    const String pushChars =
        '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
    int lastPushTime = 0;
    List lastRandChars = [];
    int now = DateTime.now().millisecondsSinceEpoch;
    bool duplicateTime = (now == lastPushTime);
    lastPushTime = now;
    List timeStampChars = List<String>.filled(8, '0');
    for (int i = 7; i >= 0; i--) {
      timeStampChars[i] = pushChars[now % 64];
      now = (now / 64).floor();
    }
    if (now != 0) {
      print("Id should be unique");
    }
    String uniqueId = timeStampChars.join('');
    if (!duplicateTime) {
      for (int i = 0; i < 12; i++) {
        lastRandChars.add((Random().nextDouble() * 64).floor());
      }
    } else {
      int i = 0;
      for (int i = 11; i >= 0 && lastRandChars[i] == 63; i--) {
        lastRandChars[i] = 0;
      }
      lastRandChars[i]++;
    }
    for (int i = 0; i < 12; i++) {
      uniqueId += pushChars[lastRandChars[i]];
    }
    return uniqueId;
  }
  static String extractDate(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String date = '${dateTime.year}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')}';
    return date;
  }
  Future<void> loadUrl(url) async {
    final Uri _url = Uri.parse(url);
    try{
      if (!await launchUrl(_url)) {
        throw SnackbarService.showSnackbar(title: "Could not launch invalid url", backgroundColor: AppColors.colorError);
      }
    }catch(e){
      SnackbarService.showSnackbar(title: "Could not launch invalid url", backgroundColor: AppColors.colorError);
    }

  }
}




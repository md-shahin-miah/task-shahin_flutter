import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider<bool>((ref){
  return Connectivity().onConnectivityChanged.map((event) => ConnectivityUtility.checkConnectivity(event));
});


class ConnectivityUtility{
  static bool checkConnectivity(List<ConnectivityResult> result){
    // for(int i=0;i<result.length;i++){

      if(result.contains(ConnectivityResult.none)){
        return false;

      }
      else{
        return true;
      }
    // }

    // switch(result){
    //   case ConnectivityResult.wifi:
    //   case ConnectivityResult.ethernet:
    //   case ConnectivityResult.mobile:
    //     return true;
    //   default:
    //     return false;
    // }
  }
}
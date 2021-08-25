import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionChecker {
  static Future<bool> CheckInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("not connected");
      return false;
    }
    print("connected");
    print(connectivityResult);
    return true;
  }
}

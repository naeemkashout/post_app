import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:post_app/core/internet_connection/internet_connection.dart';

class ConnectivityInternetConnection implements InternetConnection {
  @override
  Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo{
  final Connectivity _connectivity;
  NetworkInfoImpl({
    required Connectivity connectivity
  }) : _connectivity = connectivity; 
  @override
  Future<bool> get isConnected async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      print(1);
      return false;
    } else {
      print(2);
      return true;
    }
  }
}
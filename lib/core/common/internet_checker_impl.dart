import 'dart:async';
import 'dart:io';

import 'package:aura_interiors/core/utils/internet_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCheckerImpl implements InternetChecker {
  @override
  Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.any((result) => result != ConnectivityResult.none)) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup(
        'example.com',
      ).timeout(Duration(seconds: 5));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false; // Could not reach the server.
    } on TimeoutException catch (_) {
      return false; // Ping Timed out.
    }
  }
}

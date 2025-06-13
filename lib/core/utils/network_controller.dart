import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:safe_bus/core/styles/colors.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  bool isOpen = false;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.isEmpty ||
        connectivityResults.first == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: KColors.fadedRed,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      isOpen = true;
    } else {
      if (isOpen) {
        Fluttertoast.cancel();
        isOpen = false;
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safe_bus/core/styles/colors.dart';

class Toast {
  late FToast fToast;

  Toast(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
  }
  void showToast({
    required String message,
    Color color = KColors.greenAccent,
    IconData icon = Icons.info,
    Color fontColor = KColors.white,
  }) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fontColor),
          SizedBox(width: 12.0),
          Text(message, style: TextStyle(color: fontColor)),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}

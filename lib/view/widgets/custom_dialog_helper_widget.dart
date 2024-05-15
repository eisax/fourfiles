import 'package:flutter/material.dart';

class DialogHelper {
  static void showGeneralDialog(BuildContext context,{required Widget child}) {
    showDialog(
        context: context,
        builder: (context) => child,
        
        
        barrierDismissible: false);
  }
}
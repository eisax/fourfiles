import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetHelper {
  static void showBottomSheet(BuildContext context, {required Widget child}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: Get.height*0.8),
          child: SingleChildScrollView(
             physics: const AlwaysScrollableScrollPhysics(),
            child: child),
        );
      },
    );
  }
}

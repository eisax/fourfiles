import 'package:flutter/material.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:get/get.dart';

class BottomSheetHelper {
  static void showBottomSheet(BuildContext context, {required Widget child,Color color=Colors.transparent}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (BuildContext context) {
        return Container(
          color: color,
          constraints: BoxConstraints(maxHeight: Get.height*0.8),
          child: Padding(
            padding:  EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: SingleChildScrollView(
               physics: const AlwaysScrollableScrollPhysics(),
              child: child),
          ),
        );
      },
    );
  }
}

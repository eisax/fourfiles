
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fourfiles/util/dimensiona.dart';

class BottomModalWidget extends StatelessWidget {
final  Widget widget;

  const BottomModalWidget({
    Key? key,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: widget,
      ),
    );
  }
}
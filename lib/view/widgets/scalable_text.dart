import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
 
    double val = ( Get.width * 0.6 / 5000);
    return max(1, min(val, maxTextScaleFactor));
  }
}
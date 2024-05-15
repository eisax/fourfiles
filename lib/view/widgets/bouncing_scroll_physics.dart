import 'package:flutter/material.dart';

class BouncingScrollBehavior extends ScrollBehavior {
  // ignore: override_on_non_overriding_member
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

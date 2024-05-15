import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final Color activeColor;
  final Color deactivatedColor;
  final Color backgroundColor;
  final double value;

  const CustomProgressBar({
    Key? key,
    required this.width,
    required this.height,
    required this.activeColor,
    required this.deactivatedColor,
    required this.backgroundColor,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: deactivatedColor,
          valueColor: AlwaysStoppedAnimation<Color>(activeColor),
        ),
      ),
    );
  }
}
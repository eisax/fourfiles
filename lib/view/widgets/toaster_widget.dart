import 'package:flutter/material.dart';

enum ToasterType { error, success }

class Toaster {
  final ToasterType type;
  final String message;

  Toaster({required this.type, required this.message});

  void show(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (type) {
      case ToasterType.error:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
      case ToasterType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
    }

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.1,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the toaster after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

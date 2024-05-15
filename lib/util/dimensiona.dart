import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 16 : 12;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 18 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 22 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 28 : 24;
  static double fontSizeHeaders = Get.context!.width >= 1300 ? 40 : 40;

  static double buttonWidthDefault = Get.context!.width >= 1300
      ? Get.context!.width * 0.5
      : Get.context!.width * 0.9;

  static double paddingSizeExtraSmall = 5.0;
  static double paddingSizeSmall = 10.0;
  static double paddingSizeDefault = 15.0;
  static double paddingSizeLarge = 20.0;
  static double paddingSizeExtraLarge = 25.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double defaultSpacing = 15.0;
  static const double defaultButtonHeight = 60.0;
  static double radiusExtraLarge = 20.0;
}

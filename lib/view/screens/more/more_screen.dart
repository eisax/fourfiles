import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/helper/route_helper.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:get/get.dart';

class MoreItems {
  int id;
  String title;
  String route;
  String icon;

  MoreItems(
      {required this.id,
      required this.title,
      required this.route,
      required this.icon});
}

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "More",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFf1f1f1),
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      Dimensions.radiusExtraLarge,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radiusSmall,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          Images.logo,
                          height: 18,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Dimensions.paddingSizeExtraSmall,
                            ),
                            Text(
                              "four",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                            ),
                            Text(
                              "files",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      color: Colors.white),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.categorytypelist),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.category,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Categories",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.backup,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Backup And Restore",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.moresettings,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Settings",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.lock,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "App Lock",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.about,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "About fourfiles",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSmall),
                      color: Colors.white),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.starShine,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Rate the app",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.share,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Share App",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.shieldInfo,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Privacy Policy",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(""),
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeDefault,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.termsOfService,
                                    color: Theme.of(context).primaryColor,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Terms of Service",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).hintColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Version 1.0.0",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

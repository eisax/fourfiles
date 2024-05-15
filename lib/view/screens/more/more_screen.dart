import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    List<MoreItems> itemList = [
      MoreItems(id: 0, icon: Images.profile, title: 'My Profile', route: ""),
      MoreItems(id: 0, icon: Images.cloud, title: 'Manage Address', route: ""),
      MoreItems(id: 0, icon: Images.cloud, title: 'Language', route: ""),
      MoreItems(id: 0, icon: Images.cloud, title: 'Change Password', route: ""),
      MoreItems(id: 0, icon: "", title: 'Terms & Conditions', route: ""),
      MoreItems(id: 0, icon: Images.cloud, title: 'Privacy Policy', route: ""),
    ];
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
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.75),
                          Theme.of(context).primaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radiusDefault,
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.paddingSizeExtraLarge,
                          backgroundColor: Theme.of(context).hintColor,
                          backgroundImage:
                              AssetImage("assets/images/profile/profile.jpg"),
                        ),
                        SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Audrey Goredema",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Text(
                              "audreyg@gmail.com",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      color: Colors.white),
                  padding: EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  child: Column(
                    children: itemList
                        .map(
                          (MoreItems item) => GestureDetector(
                            onTap: () => Get.toNamed(item.route),
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: Dimensions.paddingSizeSmall,
                              ),
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeDefault,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        item.icon,
                                        color: Theme.of(context).primaryColor,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: Dimensions.paddingSizeSmall,
                                      ),
                                      Text(
                                        item.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    Images.cloud,
                                    color: Theme.of(context).hintColor,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Divider(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  thickness: Dimensions.paddingSizeDefault,
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusDefault),
                      color: Colors.white),
                  padding: EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Images.cloud,
                            color: Colors.red,
                            height: 20,
                          ),
                          SizedBox(
                            width: Dimensions.paddingSizeSmall,
                          ),
                          Text(
                            "Log out",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        Images.cloud,
                        color: Theme.of(context).hintColor,
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  thickness: Dimensions.paddingSizeExtraLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

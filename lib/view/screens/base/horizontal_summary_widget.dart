import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:get/get.dart';

class HorizontalSummaryWidget extends StatefulWidget {
  const HorizontalSummaryWidget({super.key});

  @override
  State<HorizontalSummaryWidget> createState() =>
      _HorizontalSummaryWidgetState();
}

class _HorizontalSummaryWidgetState extends State<HorizontalSummaryWidget> {
  bool itemInCart = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeLarge),

        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 10,
                blurRadius: 20,
                offset: const Offset(3, 3),
              ),
            ],
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: Colors.white,
                        image: const DecorationImage(
                            image: AssetImage("assets/images/agriculture.jpg"),
                            fit: BoxFit.cover)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.cloud,
                              width: 24,
                              height: 24,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeExtraSmall,
                            ),
                            Text(
                              "Document 1",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            //delete item from favourites
                          },
                          child: SvgPicture.asset(
                            Images.cloud,
                            color: Colors.grey,
                            height: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "April 09, 2024",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.25)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.cloud,
                              width: 16,
                              height: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeExtraSmall,
                            ),
                            Text(
                              "Task(0/2)",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeExtraSmall,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusExtraLarge,
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).disabledColor,
                                  )),
                              child: Text(
                                "More Details",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

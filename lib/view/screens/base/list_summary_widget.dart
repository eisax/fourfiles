import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:get/get.dart';

class ListSummaryWidget extends StatefulWidget {
  const ListSummaryWidget({super.key});

  @override
  State<ListSummaryWidget> createState() =>
      _ListSummaryWidgetState();
}

class _ListSummaryWidgetState extends State<ListSummaryWidget> {
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
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(
              width: 80,
              height: 80,
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
            SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

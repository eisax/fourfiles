// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/view/screens/base/bottom_sheet_helper.dart';
import 'package:get/get.dart';

class DialogButtonWidget extends StatefulWidget {
  final String hint;
  String? value;
  final Color? fillColor;
  final Color? borderColor;

  DialogButtonWidget(
      {super.key,
      required this.hint,
      this.borderColor,
      this.fillColor,
      this.value});

  @override
  State<DialogButtonWidget> createState() => _DialogButtonWidgetState();
}

class _DialogButtonWidgetState extends State<DialogButtonWidget> {
  String filter = "Name Ascending";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.radiusDefault,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "Name Ascending",
            "Name Descending",
            "Date Ascending",
            "Date Descending",
            "Favourite Ascending",
            "Favourite Descending"
          ]
              .map(
                (value) => GestureDetector(
                  onTap: () {
                    setState(() {
                      filter = value;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      Dimensions.paddingSizeSmall,
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          width: 20,
                          height: 20,
                          duration: const Duration(milliseconds: 600),
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1,
                                  color: filter == value
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).hintColor)),
                          child: Stack(
                            children: [
                              filter == value
                                  ? AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      padding: EdgeInsets.all(
                                        Dimensions.paddingSizeExtraSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 1,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.paddingSizeSmall,
                        ),
                        Text(
                          value,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

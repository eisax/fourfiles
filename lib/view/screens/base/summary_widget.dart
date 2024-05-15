import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';

enum WidgetType { grid, block, list }

class SummaryWidget extends StatefulWidget {
  final WidgetType? widgetType;
  final double? itemWidth;
  final double? itemHeight;
  const SummaryWidget(
      {super.key,
      this.widgetType = WidgetType.list,
      this.itemWidth,
      this.itemHeight});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        width: widget.itemWidth,
        height: widget.itemHeight,
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: widget.widgetType != WidgetType.grid
            ? EdgeInsets.all(
                Dimensions.paddingSizeSmall,
              )
            : null,
        margin: widget.widgetType != WidgetType.grid
            ? EdgeInsets.all(
                Dimensions.paddingSizeSmall,
              )
            : null,
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
          color: Colors.white,
        ),
        child: Stack(
          children: [
            if (widget.widgetType == WidgetType.list)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSmall,
                                ),
                                color: Theme.of(context).hintColor),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSmall,
                                ),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSmall,
                                ),
                                child: SvgPicture.asset(
                                  Images.pdf,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5)),
                              child: Text(
                                "1",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: SvgPicture.asset(
                          Images.document,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      Text(
                        "Document 1",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: SvgPicture.asset(
                          Images.listCheck,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: SvgPicture.asset(
                          Images.star,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            if (widget.widgetType == WidgetType.block)
              Row(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSmall,
                            ),
                            color: Theme.of(context).hintColor),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSmall,
                            ),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSmall,
                            ),
                            child: SvgPicture.asset(
                              Images.pdf,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.5)),
                          child: Text(
                            "1",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: Dimensions.paddingSizeExtraSmall,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    Images.document,
                                    color: Theme.of(context).hintColor,
                                  ),
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
                                        fontWeight: FontWeight.w500,
                                      ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                Images.more,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
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
                                  "May 07, 2024",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).hintColor),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                Images.star,
                                color: Colors.yellow,
                              ),
                            ),
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
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    Images.listCheck,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall,
                                ),
                                Text(
                                  "Task(1/2)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).hintColor),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraSmall,
                                horizontal: Dimensions.paddingSizeSmall,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusExtraLarge,
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              child: Text(
                                "View More",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context).hintColor,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (widget.widgetType == WidgetType.grid)
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                Dimensions.radiusDefault,
                              ),
                              topRight: Radius.circular(
                                Dimensions.radiusDefault,
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusSmall,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusSmall,
                              ),
                              child: SvgPicture.asset(
                                Images.pdf,
                                height: widget.itemWidth! * 0.5,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.paddingSizeExtraSmall,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5)),
                                  child: SvgPicture.asset(
                                    Images.document,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.paddingSizeSmall,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.5)),
                                  child: Text(
                                    "1",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      child: Row(
                        children: [
                          Text(
                            "Document 1",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

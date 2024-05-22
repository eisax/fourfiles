import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/file/view_file_screen.dart';

enum WidgetType { grid, block, list }

class CategorySummaryWidget extends StatefulWidget {
  final double? itemWidth;
  final double? itemHeight;
  const CategorySummaryWidget({super.key, this.itemWidth, this.itemHeight});

  @override
  State<CategorySummaryWidget> createState() => _CategorySummaryWidgetState();
}

class _CategorySummaryWidgetState extends State<CategorySummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewFileScreen()),
        );
      },
      child: AnimatedContainer(
        width: widget.itemWidth,
        height: widget.itemHeight,
        duration: const Duration(
          milliseconds: 500,
        ),
        padding: EdgeInsets.all(
          Dimensions.paddingSizeSmall,
        ),
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
                          padding: EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall,
                          ),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFf0f0f0)),
                          child: Container(
                            padding: EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall,
                            ),
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
                                Images.cat14,
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
                              color: Theme.of(context).primaryColor,
                            ),
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
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      "Passport",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        Images.more,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

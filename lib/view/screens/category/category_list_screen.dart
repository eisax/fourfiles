import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/base/bottom_sheet_helper.dart';
import 'package:fourfiles/view/screens/base/dialog_dropdown_widget.dart';
import 'package:fourfiles/view/screens/base/list_summary_widget.dart';
import 'package:fourfiles/view/screens/base/summary_widget.dart';
import 'package:fourfiles/view/screens/create/create_file_screen.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  WidgetType widgetType = WidgetType.grid;
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 50,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          Images.back,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Text(
                      "All Documents",
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.fontSizeExtraLarge,
                              ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      padding: EdgeInsets.all(
                        Dimensions.paddingSizeSmall,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            spreadRadius: 1,
                            blurRadius: 50,
                            offset: const Offset(
                              0,
                              3,
                            ),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        Images.search,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.paddingSizeExtraSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (widgetType == WidgetType.grid) {
                            widgetType = WidgetType.list;
                          } else if (widgetType == WidgetType.list) {
                            widgetType = WidgetType.block;
                          } else if (widgetType == WidgetType.block) {
                            widgetType = WidgetType.grid;
                          } else {
                            widgetType = WidgetType.list;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 35,
                        height: 35,
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 50,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          widgetType == WidgetType.grid
                              ? Images.list
                              : (widgetType == WidgetType.list
                                  ? Images.grid1
                                  : Images.grid2),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.paddingSizeExtraSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        BottomSheetHelper.showBottomSheet(context,
                            child: Column(
                              children: [
                                DialogButtonWidget(
                                  hint: '',
                                )
                              ],
                            ));
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).shadowColor,
                              spreadRadius: 1,
                              blurRadius: 50,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          Images.reverse,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: widgetType == WidgetType.grid
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  width: Get.width,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = ((constraints.maxWidth -
                              (Dimensions.paddingSizeSmall * 2)) /
                          2);

                      return Wrap(
                        direction: Axis.horizontal,
                        runSpacing: Dimensions.paddingSizeDefault,
                        alignment: WrapAlignment.spaceBetween,
                        runAlignment: WrapAlignment.spaceEvenly,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: ["", "", ""]
                            .map((e) => SummaryWidget(
                                  itemWidth: cardWidth,
                                  widgetType: WidgetType.grid,
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              )
            : Column(
                children: [""]
                    .map((e) => SummaryWidget(
                          widgetType: widgetType,
                        ))
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateFileScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4.0,
        splashColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
      ),
    );
  }
}

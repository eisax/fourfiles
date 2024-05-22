import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/base/bottom_sheet_helper.dart';
import 'package:fourfiles/view/screens/base/category_list_summary.dart';
import 'package:fourfiles/view/screens/base/dialog_dropdown_widget.dart';
import 'package:fourfiles/view/screens/more/widget/create_category_screen.dart';
import 'package:get/get.dart';

class CategoryTypesListScreen extends StatefulWidget {
  const CategoryTypesListScreen({super.key});

  @override
  State<CategoryTypesListScreen> createState() =>
      _CategoryTypesListScreenState();
}

class _CategoryTypesListScreenState extends State<CategoryTypesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0f0f0),
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
                      "Categories",
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
                      onTap: () {},
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
                          Images.touch,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall,
            vertical: Dimensions.paddingSizeDefault,
          ),
          child: Column(
            children: [""].map((e) => const CategorySummaryWidget()).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCategoryScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4.0,
        splashColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

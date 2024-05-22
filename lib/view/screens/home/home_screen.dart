import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/controller/document_controller.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/category/category_list_screen.dart';
import 'package:get/get.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
   return GetBuilder<DocumentController>(builder: (documentController) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f1f1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      "four",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.fontSizeOverLarge,
                              ),
                    ),
                    Text(
                      "files",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: Dimensions.fontSizeOverLarge,
                              color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Image.asset(
                  Images.logo,
                  height: 34,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = ((constraints.maxWidth -
                        (Dimensions.paddingSizeSmall * 4)) /
                    2);

                return Wrap(
                    direction: Axis.horizontal,
                    runSpacing: Dimensions.paddingSizeSmall,
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: documentController.categories
                        .map(
                          (category) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoryListScreen()),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Container(
                                padding: EdgeInsets.all(
                                  Dimensions.paddingSizeSmall,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall,
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .shadowColor
                                          .withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                width: cardWidth,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child:SvgPicture.asset(
                                        category.icon
                                      )
                                    ),
                                    Text(
                                      category.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList());
              },
            ),
          ),
        ),
      ),
    );
  });}
}

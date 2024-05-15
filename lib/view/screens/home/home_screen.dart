import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/category/category_list_screen.dart';
import 'package:get/get.dart';

class CategoriesButton {
  int id;
  String title;
  String route;
  String icon;

  CategoriesButton(
      {required this.id,
      required this.title,
      required this.route,
      required this.icon});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    List<CategoriesButton> categories = [
    CategoriesButton(
        icon: Images.cat1, id: 0, title: 'Uncategorized', route: ''),
    CategoriesButton(
        icon: Images.cat2, id: 1, title: 'Driving License', route: ''),
    CategoriesButton(icon: Images.cat3, id: 2, title: 'Insurance', route: ''),
    CategoriesButton(icon: Images.cat4, id: 2, title: 'Passport', route: ''),
    CategoriesButton(icon: Images.cat5, id: 2, title: 'Invoice', route: ''),
    CategoriesButton(
        icon: Images.cat6, id: 2, title: 'Personal Card', route: ''),
    CategoriesButton(icon: Images.cat7, id: 2, title: 'Bank', route: ''),
    CategoriesButton(icon: Images.cat8, id: 2, title: 'Medical', route: ''),
    CategoriesButton(
        icon: Images.cat9, id: 2, title: 'Business Card', route: ''),
    CategoriesButton(icon: Images.cat10, id: 2, title: 'Contract', route: ''),
    CategoriesButton(icon: Images.cat11, id: 2, title: 'Product', route: ''),
    CategoriesButton(
        icon: Images.cat12, id: 2, title: 'Electricity/Gas', route: ''),
    CategoriesButton(icon: Images.cat13, id: 2, title: 'Bills', route: ''),
  ];
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
                    children: categories
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
  }
}

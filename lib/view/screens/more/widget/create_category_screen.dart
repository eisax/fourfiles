// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/widgets/textinput_widget.dart';
import 'package:get/get.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0f0f0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            color: const Color(0xfff0f0f0),
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
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Dimensions.paddingSizeExtraSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        // BottomSheetHelper.showBottomSheet(context,
                        //     child: Column(
                        //       children: [
                        //         DialogButtonWidget(
                        //           hint: '',
                        //         )
                        //       ],
                        //     ));
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
                          Images.save,
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
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category Name",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 5),
                            child: CustomTextField(
                              hintText: '',
                              controller: TextEditingController(),
                              fillColor: Colors.white,
                              inputType: TextInputType.emailAddress,
                              borderColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.paddingSizeSmall,
                        ),
                        SizedBox(
                          height: 45,
                          width: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              animationDuration:
                                  const Duration(milliseconds: 500),
                              elevation: 0,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSmall,
                                ),
                              ),
                              padding: const EdgeInsets.all(
                                2,
                              ),
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () async {},
                            child: Container(
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeSmall,
                              ),
                              child: SvgPicture.asset(
                                Images.cat28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Text(
                "Fields",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusSmall,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(
                                    Dimensions.paddingSizeSmall,
                                  ),
                                  child: SvgPicture.asset(
                                    Images.scroll,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Text(
                                  "First Name",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeSmall,
                              ),
                              child: SvgPicture.asset(
                                Images.delete,
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                  
                    ],
                  ),
                ),
              )
            ],
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

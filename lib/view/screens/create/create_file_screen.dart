import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/widgets/textinput_widget.dart';
import 'package:get/get.dart';

class CreateFileScreen extends StatefulWidget {
  const CreateFileScreen({super.key});

  @override
  State<CreateFileScreen> createState() => _CreateFileScreenState();
}

class _CreateFileScreenState extends State<CreateFileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusExtraLarge,
                        ),
                        color: Colors.white),
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                        horizontal: Dimensions.paddingSizeSmall),
                    child: Text(
                      "Back",
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusExtraLarge,
                            ),
                            color: Colors.white),
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeExtraSmall,
                            horizontal: Dimensions.paddingSizeSmall),
                        child: Text(
                          "Save",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                        ),
                      ),
                    ),
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
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: Get.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        animationDuration: const Duration(milliseconds: 500),
                        elevation: 0,
                        backgroundColor: Theme.of(context).primaryColor,
                        textStyle: const TextStyle(
                            color: Colors.white, fontStyle: FontStyle.normal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSmall,
                          ),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {},
                      child: Text(
                        "Uncategorized",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: Get.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        animationDuration: const Duration(milliseconds: 500),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        textStyle: const TextStyle(
                            color: Colors.white, fontStyle: FontStyle.normal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSmall,
                          ),
                          side: BorderSide(
                            width: 1,
                            color: Theme.of(context).hintColor.withOpacity(
                                0.5,
                              )
                          )
                        ),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {},
                      child: Text(
                        "Add Document",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      Text(
                        "Document Title",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomTextField(
                          hintText: '',
                          controller: TextEditingController(),
                          fillColor: Colors.transparent,
                          inputType: TextInputType.emailAddress,
                          borderColor: Theme.of(context).hintColor.withOpacity(
                                0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomTextField(
                          hintText: '',
                          controller: TextEditingController(),
                          fillColor: Colors.transparent,
                          inputType: TextInputType.emailAddress,
                          borderColor: Theme.of(context).hintColor.withOpacity(
                                0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

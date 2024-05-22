// ignore_for_file: deprecated_member_use, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/controller/document_controller.dart';
import 'package:fourfiles/data/model/category_model.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/base/bottom_sheet_helper.dart';
import 'package:fourfiles/view/widgets/dialog_helper.dart';
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
    return GetBuilder<DocumentController>(builder: (documentController) {
      return Scaffold(
        backgroundColor: Colors.white,
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
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall,
                    ),
                    child: SizedBox(
                      height: 60,
                      width: Get.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          animationDuration: const Duration(milliseconds: 500),
                          elevation: 0,
                          backgroundColor: const Color(0xfff0f0f0),
                          textStyle: const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSmall,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          BottomSheetHelper.showBottomSheet(
                            context,
                            child: Column(
                              children: [
                                CategoryBottomSelectionDialog(
                                  hint: '',
                                )
                              ],
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    Dimensions.paddingSizeSmall,
                                  ),
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: SvgPicture.asset(
                                    documentController.selectedCategory?.icon ??
                                        "",
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.paddingSizeSmall,
                                ),
                                Text(
                                  documentController.selectedCategory?.title ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).shadowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusSmall,
                        ),
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).hintColor.withOpacity(
                                0.5,
                              ),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: Get.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                animationDuration:
                                    const Duration(milliseconds: 500),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall,
                                  ),
                                ),
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () async {
                                BottomSheetHelper.showBottomSheet(
                                  context,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      AddDocumentBottomDialog(
                                        hint: '',
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Images.addcircle,
                                    height: 18,
                                    width: 18,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    "Add Document",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: documentController.documentimages
                                    .map(
                                      (image) => Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(Dimensions
                                                .paddingSizeExtraSmall),
                                            margin: EdgeInsets.all(
                                              Dimensions.paddingSizeExtraSmall,
                                            ),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(image),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radiusLarge),
                                              color: Colors.white,
                                            ),
                                            height: 100,
                                            width: 100,
                                          ),
                                          Positioned(
                                            child: GestureDetector(
                                              onTap: () {
                                                documentController
                                                    .deleteImage(image);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(
                                                  3,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.white)),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          "Document Title",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).hintColor,
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
                            fillColor: const Color(0xFFf0f0f0),
                            inputType: TextInputType.emailAddress,
                            borderColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeExtraLarge,
                        ),
                        Text(
                          "Tasks/Todo",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
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
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeSmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            DialogHelper.showGeneralDialog(
                              context,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AddItemDialog(
                                    hint: '',
                                  )
                                ],
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                Images.addcircle,
                                height: 18,
                                width: 18,
                                color: Theme.of(context).hintColor,
                              ),
                              SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                "List Item",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).hintColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class AddItemDialog extends StatefulWidget {
  final String hint;
  String? value;
  final Color? fillColor;

  AddItemDialog({super.key, required this.hint, this.fillColor, this.value});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (documentController) {
      return Card(
        margin: EdgeInsets.all(
          Dimensions.paddingSizeDefault,
        ),
        elevation: 0,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: Get.width,
            padding: EdgeInsets.all(
              Dimensions.paddingSizeDefault,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Dimensions.radiusLarge,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Add Task",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.fontSizeExtraLarge),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                Divider(
                  height: 1,
                  color: Theme.of(context).dividerColor.withOpacity(
                        0.25,
                      ),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeLarge,
                ),
                SizedBox(
                  height: 50,
                  child: CustomTextField(
                    hintText: 'Enter Task Name',
                    controller: TextEditingController(),
                    fillColor: const Color(0xFFf0f0f0),
                    inputType: TextInputType.emailAddress,
                    borderColor: Theme.of(context).hintColor.withOpacity(0.25),
                  ),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeExtraLarge,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            animationDuration:
                                const Duration(milliseconds: 500),
                            elevation: 0,
                            backgroundColor: const Color(0xfff0f0f0),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusLarge,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            animationDuration:
                                const Duration(milliseconds: 500),
                            elevation: 0,
                            backgroundColor: Theme.of(context).primaryColor,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusLarge,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () async {},
                          child: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
      );
    });
  }
}

class AddDocumentBottomDialog extends StatefulWidget {
  final String hint;
  String? value;
  final Color? fillColor;

  AddDocumentBottomDialog(
      {super.key, required this.hint, this.fillColor, this.value});

  @override
  State<AddDocumentBottomDialog> createState() =>
      _AddDocumentBottomDialogState();
}

class _AddDocumentBottomDialogState extends State<AddDocumentBottomDialog> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (documentController) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: Get.width,
          padding: EdgeInsets.all(
            Dimensions.paddingSizeDefault,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          animationDuration: const Duration(milliseconds: 500),
                          elevation: 0,
                          backgroundColor: const Color(0xfff0f0f0),
                          textStyle: const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          await documentController.pickImage(isCamera: true);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall,
                              ),
                              width: 75,
                              height: 75,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Images.camera,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      "Camera",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          animationDuration: const Duration(milliseconds: 500),
                          elevation: 0,
                          backgroundColor: const Color(0xfff0f0f0),
                          textStyle: const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          BottomSheetHelper.showBottomSheet(
                            context,
                            child: Column(
                              children: [
                                CategoryBottomSelectionDialog(
                                  hint: '',
                                )
                              ],
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall,
                              ),
                              width: 75,
                              height: 75,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Images.documentFile,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      "DOCS",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          animationDuration: const Duration(milliseconds: 500),
                          elevation: 0,
                          backgroundColor: const Color(0xfff0f0f0),
                          textStyle: const TextStyle(
                              color: Colors.white, fontStyle: FontStyle.normal),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                          ),
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          await documentController.pickImage(isCamera: false);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall,
                              ),
                              width: 75,
                              height: 75,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Images.gallery,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      "Gallery",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CategoryBottomSelectionDialog extends StatefulWidget {
  final String hint;
  String? value;
  final Color? fillColor;

  CategoryBottomSelectionDialog(
      {super.key, required this.hint, this.fillColor, this.value});

  @override
  State<CategoryBottomSelectionDialog> createState() =>
      _CategoryBottomSelectionDialogState();
}

class _CategoryBottomSelectionDialogState
    extends State<CategoryBottomSelectionDialog> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (documentController) {
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
            children: documentController.categories
                .map(
                  (value) => GestureDetector(
                    onTap: () {
                      documentController.selectCategory(value);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                        Dimensions.paddingSizeSmall,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraSmall,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSmall,
                          ),
                          color: const Color(0xFFf0f0f0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  Dimensions.paddingSizeSmall,
                                ),
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: SvgPicture.asset(
                                  value.icon,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                value.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(),
                              ),
                            ],
                          ),
                          if (documentController.selectedCategory == value)
                            AnimatedContainer(
                              width: 25,
                              height: 25,
                              duration: const Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 18,
                              ),
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
    });
  }
}

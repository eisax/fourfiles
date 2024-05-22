import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fourfiles/util/dimensiona.dart';
import 'package:fourfiles/util/images.dart';
import 'package:fourfiles/view/screens/base/summary_widget.dart';
import 'package:fourfiles/view/screens/create/create_file_screen.dart';
import 'package:get/get.dart';

class DocumentData {
  final int id;
  final String key;
  final String value;
  DocumentData({required this.id, required this.key, required this.value});
}

class DocumentTaskData {
  final int id;
  final bool done;
  final String task;
  DocumentTaskData({required this.id, required this.done, required this.task});
}

class ViewFileScreen extends StatefulWidget {
  const ViewFileScreen({super.key});

  @override
  State<ViewFileScreen> createState() => _ViewFileScreenState();
}

class _ViewFileScreenState extends State<ViewFileScreen> {
  List<DocumentTaskData> tasks = [
    DocumentTaskData(
      id: 0,
      task: 'Task One',
      done: false,
    ),
    DocumentTaskData(
      id: 2,
      task: 'Task Two',
      done: false,
    ),
    DocumentTaskData(
      id: 0,
      task: 'Task Three',
      done: false,
    )
  ];

  List<DocumentData> data = [
    DocumentData(id: 0, key: 'Name', value: 'Kudah Ndhlovu'),
    DocumentData(id: 0, key: 'License No', value: '24244380'),
    DocumentData(id: 0, key: 'DOB', value: 'March 11 2002'),
    DocumentData(id: 0, key: 'Valid Till', value: 'March 11 2028'),
    DocumentData(id: 0, key: 'Description', value: '')
  ];
  WidgetType widgetType = WidgetType.grid;
  bool isFavourite = false;
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
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        child: isFavourite
                            ? SvgPicture.asset(
                                Images.star,
                                color: Colors.yellow,
                              )
                            : SvgPicture.asset(
                                Images.starOutline,
                                color: Theme.of(context).hintColor,
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
          padding: EdgeInsets.all(
            Dimensions.paddingSizeDefault,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusDefault,
                    ),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  Images.document,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.paddingSizeExtraSmall,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Document 1",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Text(
                                    "May, 14 2024",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).hintColor,
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              Images.more,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                            color: Theme.of(context).hintColor),
                        height: Get.height * 0.3,
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeDefault,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          Dimensions.paddingSizeSmall,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).hintColor,
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            )),
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Container(
                  padding: EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusDefault,
                    ),
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
                  child: Column(
                    children: data.map((documentData) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${documentData.key}:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              documentData.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).hintColor,
                                  ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Container(
                  padding: EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radiusDefault,
                    ),
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
                  child: Column(
                    children: tasks.map((documentTask) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.all(
                                Dimensions.paddingSizeSmall,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).disabledColor),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Text(
                              documentTask.task,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    decoration: documentTask.done
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationThickness: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
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

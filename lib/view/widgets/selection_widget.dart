// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fourfiles/util/app_constants.dart';
import 'package:fourfiles/util/dimensiona.dart';

class SingleSelectWidget extends StatefulWidget {
  final List<String> selectionWidgetList;
  final String selectedWidget;
  final ValueChanged<String> onSelectionChanged;

  const SingleSelectWidget({super.key, 
    required this.selectionWidgetList,
    required this.selectedWidget,
    required this.onSelectionChanged,
  });

  @override
  _SingleSelectWidgetState createState() => _SingleSelectWidgetState();
}

class _SingleSelectWidgetState extends State<SingleSelectWidget> {
  int tappedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.selectionWidgetList.asMap().entries.map(
        (entry) {
          int index = entry.key;
          String hobby = entry.value;
          bool isSelected = widget.selectedWidget == hobby;
        
          return GestureDetector(
            onTap: () {
              setState(() {
                tappedIndex = index;
              });
              Future.delayed(const Duration(milliseconds: 10), () {
                setState(() {
                  tappedIndex = -1;
                });
              });
        
              if (widget.selectedWidget != hobby) {
                widget.onSelectionChanged(hobby);
              }
            },
            child: AnimatedContainer(
              height: 50,
              margin: EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.25),
                    width: 0.5,
                  ),
                  color: AppConstants.color2,
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.25),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white : null,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      Text(
                        hobby,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

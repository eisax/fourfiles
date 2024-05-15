import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fourfiles/util/dimensiona.dart';

class CustomDropdownWidget extends StatefulWidget {
  final List<String> selectionWidgetList;
  final String? selectedWidget;
  final ValueChanged<String> onSelectionChanged;

  CustomDropdownWidget({
    required this.selectionWidgetList,
    required this.selectedWidget,
    required this.onSelectionChanged,
  });

  @override
  _CustomDropdownWidgetState createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.25),
          width: 0.5,
        ),
        
      ),
      child: Center(
        child: DropdownButton<String>(
          hint: Text(
                  "Select",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
          elevation: 5,
          underline: Container(),
          isExpanded: true,
          value: widget.selectedWidget,
          onChanged: (String? newValue) {
            if (newValue != null) {
              widget.onSelectionChanged(newValue);
            }
          },
          items: widget.selectionWidgetList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeExtraSmall),
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

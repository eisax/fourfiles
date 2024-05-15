import 'package:flutter/material.dart';
import 'package:fourfiles/util/dimensiona.dart';

class CustomCheckboxWidget extends StatefulWidget {
  final bool isSelected;
  final Function(bool) onChanged;
  final Color activeColor;
  final Color checkColor;
  final double width;
  final double height;
  final EdgeInsets padding;

  CustomCheckboxWidget({
    required this.isSelected,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
    this.width = 50.0,
    this.height = 30.0,
    this.padding = const EdgeInsets.all(4.0),
  });

  @override
  _CustomCheckboxWidgetState createState() => _CustomCheckboxWidgetState();
}

class _CustomCheckboxWidgetState extends State<CustomCheckboxWidget> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onChanged(isSelected);
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(
            color: isSelected ? widget.activeColor : widget.activeColor.withOpacity(0.5),
          ),
          color: isSelected ? widget.activeColor : widget.checkColor,
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                size: widget.height * 0.5,
                color: widget.checkColor,
              )
            : null,
      ),
    );
  }
}

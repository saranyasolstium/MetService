import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool? isChecked;
  final double? size;
  final double? iconSize;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final Function(bool)? didSelect;

  CustomCheckbox(
      {this.isChecked,
      this.size,
      this.iconSize,
      this.selectedColor,
      this.selectedIconColor,
      this.didSelect});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        didSelect!(!this.isChecked!);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: this.isChecked!
                ? selectedColor ?? Colors.blue
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
            border: this.isChecked!
                ? null
                : Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  )),
        width: size ?? 30,
        height: size ?? 30,
        child: this.isChecked!
            ? Icon(
                Icons.check,
                color: selectedIconColor ?? Colors.white,
                size: iconSize ?? 20,
              )
            : null,
      ),
    );
  }
}

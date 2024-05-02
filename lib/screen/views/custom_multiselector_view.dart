import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CustomMultiSelectItem<T> extends MultiSelectItem<T> {
  final String checkBoxSize;

  CustomMultiSelectItem(T value, bool selected, this.checkBoxSize) : super(value, selected as String);

  @override
  Widget build(BuildContext context, bool? selected, Function(T) onTap) {
    return InkWell(
      onTap: () => onTap(value),
      child: Row(
        children: [
          Checkbox(
            value: selected ?? false,
            onChanged: (bool? newValue) => onTap(value),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: _getCheckBoxSize(checkBoxSize),
              // Add more styling here if needed
            ),
          ),
        ],
      ),
    );
  }

  double _getCheckBoxSize(String size) {
    switch (size) {
      case 'N':
        return 12.0;
      case 'L':
        return 18.0;
      case 'M':
        return 24.0;
      case 'H':
        return 30.0;
      default:
        return 12.0; // Default size
    }
  }
}

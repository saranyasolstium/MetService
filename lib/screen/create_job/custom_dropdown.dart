import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final Function(String?) onChanged;

  CustomDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8.dynamic),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.dynamic)),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

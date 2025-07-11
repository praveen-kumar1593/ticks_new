import 'package:ticks_new/constants/r_colors.dart';
import 'package:flutter/material.dart';


import 'custom_text_style.dart';


class CustomDropDown<T> extends StatelessWidget {
  final double iconSize;
  final Color iconColor;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;

  const CustomDropDown({
    super.key,
    this.iconSize = 16.0,
    this.iconColor = Colors.black,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      alignment: Alignment.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        floatingLabelAlignment: FloatingLabelAlignment.center,
      ),

      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      dropdownColor: RColors.pureWhite,
      hint:
          hintText != null
              ? Text(hintText!, style: const CustomTextStyle(fontSize: 14, fontWeight: FontWeight.w500))
              : null,

      icon: Padding(
        padding: const EdgeInsets.only(left: 10), // Space between text and arrow
        child: Icon(Icons.arrow_drop_down, size: iconSize, color: iconColor),
      ),

      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}

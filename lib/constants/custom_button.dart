
import 'package:flutter/material.dart';
import 'package:ticks_new/constants/r_colors.dart';



import 'custom_text_style.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.color,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: RColors.orange,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(width ?? 0, height ?? 0),
      ),

      onPressed: onPressed,
      child: Text(
        label,
        style: CustomTextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color ?? RColors.pureWhite),
      ),
    );
  }
}

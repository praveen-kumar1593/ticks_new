
import 'package:flutter/material.dart';
import 'package:ticks_new/constants/r_colors.dart';

import 'custom_text_style.dart';


class CustomTextFeild extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final Widget? suffix;
  final Widget? prefix;
  final bool isRequired;
  final String? errorMessage;
  final bool isHidden;
  final bool readOnly;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final Color? fillColor;

  const CustomTextFeild({
    super.key,
    this.label,
    this.hint,
    required this.controller,
    this.suffix,
    this.prefix,
    this.isRequired = false,
    this.isHidden = false,
    this.errorMessage,
    this.readOnly = false,
    this.autofillHints,
    this.validator,
    this.fillColor,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text.rich(
            TextSpan(
              text: widget.isRequired ? "* " : "",
              style: CustomTextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: RColors.darkRed),
              children: [
                TextSpan(text: widget.label, style: const CustomTextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          validator:
              widget.validator ??
              (widget.isRequired
                  ? (value) => value == null || value.isEmpty ? widget.errorMessage ?? 'Required' : null
                  : null),
          obscureText: widget.isHidden,
          obscuringCharacter: '*',
          readOnly: widget.readOnly,
          autofillHints: widget.autofillHints,
          style: CustomTextStyle(color: RColors.blue, fontSize: 14, fontWeight: FontWeight.w700),
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            suffixIcon: widget.suffix,
            fillColor: widget.fillColor ?? RColors.darkGrey.withValues(alpha: 0.25),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: widget.hint,
            hintStyle: CustomTextStyle(color: RColors.darkGreyText),
            alignLabelWithHint: true,
            prefix: widget.prefix,
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }
}

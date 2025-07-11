import 'package:flutter/material.dart';

import 'custom_text_style.dart';


class CustomErrorWidget extends StatelessWidget {
  final String? message;
  const CustomErrorWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Oops! Service Unavailable. Please try again later.",
          style: CustomTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

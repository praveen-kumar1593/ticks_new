import 'package:flutter/material.dart';

import 'custom_text_style.dart';


class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Data Found", style: CustomTextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}

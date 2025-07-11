import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';


import '../../../../constants/custom_text_style.dart';
import '../../../../constants/r_colors.dart';

class ProfileSwitchTile extends StatelessWidget {
  final String svgIcon;
  final double? svgHeight;
  final String title;
  final bool value;
  final void Function(bool)? onChanged;

  const ProfileSwitchTile({
    super.key,
    required this.svgIcon,
    required this.title,
    required this.value,
    this.onChanged,
    this.svgHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        SvgPicture.asset(svgIcon, height: svgHeight ?? 18),
        Text(title, style: const CustomTextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const Spacer(),
        CupertinoSwitch(value: value, onChanged: onChanged, activeTrackColor: RColors.blue),
      ],
    );
  }
}

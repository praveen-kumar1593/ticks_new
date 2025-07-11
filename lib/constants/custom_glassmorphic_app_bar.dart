import 'dart:ui';

import 'package:ticks_new/constants/r_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


import 'custom_text_style.dart';


class CustomGlassmorphicAppBar extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final Widget? childBelowTitle;
  final double childBelowTitleHeight;

  const CustomGlassmorphicAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.childBelowTitle,
    this.childBelowTitleHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    // Total height of the app bar

    return SliverLayoutBuilder(
      builder: (BuildContext context, SliverConstraints constraints) {
        return SliverAppBar(
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: leading ?? const SizedBox.shrink(),
          title:
              title != null
                  ? Text(title!, style: CustomTextStyle(fontSize: 16, color: RColors.blue, fontWeight: FontWeight.w700))
                  : const SizedBox.shrink(),
          centerTitle: true,
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          actions: actions,
          flexibleSpace: Stack(
            children: [
              // Content behind app bar
              Positioned.fill(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.transparent],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(color: Colors.transparent),
                ),
              ),

              // Blur effect
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(decoration: BoxDecoration(color: RColors.pureWhite.withValues(alpha: 0.2))),
                  ),
                ),
              ),
            ],
          ),
          bottom:
              childBelowTitle != null
                  ? PreferredSize(
                    preferredSize: Size.fromHeight(childBelowTitleHeight),
                    child: Padding(padding: const EdgeInsets.only(bottom: 16.0), child: childBelowTitle!),
                  )
                  : null,
          //forceElevated: true,
        );
      },
    );
  }
}

class BackgroundPasser extends StatelessWidget {
  final Widget child;

  const BackgroundPasser({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0), child: child));
  }
}

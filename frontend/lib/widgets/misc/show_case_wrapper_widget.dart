import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseWrapper extends StatelessWidget {
  final GlobalKey showcaseKey;
  final String title;
  final String description;
  final Widget child;
  final VoidCallback? onTargetClick;
  final Color? tooltipBackgroundColor;
  final Color? textColor;
  final double? tooltipOpacity;
  final bool showArrow;
  final TextStyle? customTitleStyle;
  final TextStyle? customDescriptionStyle;
  final ShapeBorder? targetShapeBorder;

  const ShowcaseWrapper({
    super.key,
    required this.showcaseKey,
    required this.title,
    required this.description,
    required this.child,
    this.onTargetClick,
    this.tooltipBackgroundColor,
    this.textColor,
    this.tooltipOpacity,
    this.showArrow = true,
    this.customTitleStyle,
    this.customDescriptionStyle,
    this.targetShapeBorder,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTitleStyle = TextStyle(
      color: textColor ?? Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final defaultDescriptionStyle = TextStyle(
      color: textColor ?? Colors.white,
      fontSize: 14,
    );

    return Showcase(
      key: showcaseKey,
      title: title,
      description: description,
      targetShapeBorder: targetShapeBorder ?? const BeveledRectangleBorder(),
      tooltipBackgroundColor: tooltipBackgroundColor ?? Colors.blue,
      textColor: textColor ?? Colors.white,
      titleTextStyle: customTitleStyle ?? defaultTitleStyle,
      descTextStyle: customDescriptionStyle ?? defaultDescriptionStyle,
      showArrow: showArrow,
      overlayOpacity: tooltipOpacity ?? 0,
      blurValue: 10,
      child: child,
    );
  }
}
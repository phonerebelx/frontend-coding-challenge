
import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/view/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final double fontSize;
  final BorderRadius borderRadius;
  final Color textColor;
  final Color btnColor;
  final VoidCallback? onTap;
  final bool loading;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
  final bool isWidgetTrue;
  final Widget? customWidget; // Added to accept a custom widget

  CustomButton({
    Key? key,
    this.height,
    this.width,
    required this.textColor,
    required this.btnColor,
    required this.borderRadius,
    required this.title,
    required this.fontSize,
    this.onTap,
    this.isWidgetTrue = false,
    required this.padding,
    this.loading = false,
    this.gradient,
    this.customWidget, // Added parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: gradient == null ? btnColor : null,
            gradient: gradient,
            borderRadius: borderRadius,
          ),
          child: loading
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
              : Center(
            child: isWidgetTrue && customWidget != null
                ? customWidget // Show custom widget if condition is true
                : CustomText(
              text: title,
              textColor: textColor,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/theme/dimensions.dart';
import '/core/widgets/custom_text.dart';

import '../extensions/ext.dart';
import '../theme/light_colors.dart';
import 'bouncing_widgets.dart';

class AppButton extends StatelessWidget implements Equatable {
  final String text;
  final VoidCallback? onPressed;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Color? hoveColor;
  final FontWeight? textWeight;
  final double? textSize;
  final double? elevation;
  final double? gapLeadingText;
  final Widget? child;
  final double? height;
  final double? letterSpacing;
  final BorderSide? side;
  final double textHeight;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.radius,
    this.contentPadding,
    this.color = AppLightColors.primary,
    this.textColor,
    this.hoveColor,
    this.textSize,
    this.textWeight,
    this.elevation,
    this.letterSpacing,
    this.height,
    this.textHeight = 1.5,
    this.side,
    this.margin,
    this.borderColor = Colors.transparent,
  }) : child = null,
       gapLeadingText = null;

  const AppButton.icon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.child,
    this.gapLeadingText = 10,
    this.radius,
    this.contentPadding,
    this.color,
    this.borderColor,
    this.textColor,
    this.hoveColor,
    this.textSize,
    this.textWeight,
    this.elevation,
    this.letterSpacing,
    this.textHeight = 1.5,
    this.height,
    this.side,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return onPressed == null ? buildButton() : BounceIt(child: buildButton());
  }

  buildButton() {
    return Container(
      height: height ?? 48.h,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? 36.r),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: TextButton(
        onPressed: onPressed,
        clipBehavior: Clip.antiAlias,
        style: TextButton.styleFrom(
          side: side,
          foregroundColor: hoveColor ?? Colors.white,
          backgroundColor: Colors.transparent,
          padding: contentPadding ?? const EdgeInsets.all(8).r,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radius ?? AppDimensions.defaultRadius,
            ),
            side: side ?? BorderSide.none,
          ),
          elevation: elevation,
          fixedSize: Size(double.infinity, height ?? 56.h),
        ),
        child:
            child == null
                ? AppText(
                  text,
                  alignment: AlignmentDirectional.center,
                  maxLines: 1,
                  textHeight: textHeight.r,
                  style: TextStyle(
                    fontWeight: textWeight ?? FontWeight.w600,
                    fontSize: textSize ?? 14.sp,
                    letterSpacing: letterSpacing,
                    color: textColor,
                  ),
                )
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    30.wSpace,
                    Expanded(
                      child: AppText(
                        text,
                        alignment: AlignmentDirectional.center,
                        maxLines: 1,
                        textHeight: textHeight.r,
                        style: TextStyle(
                          fontWeight: textWeight ?? FontWeight.w700,
                          fontSize: textSize ?? 14.sp,
                          letterSpacing: letterSpacing,
                          color: textColor ?? Colors.white,
                        ),
                      ),
                    ),
                    child!,
                  ],
                ),
      ),
    );
  }

  @override
  List<Object?> get props => [
    text,
    onPressed,
    radius,
    contentPadding,
    color,
    textColor,
    hoveColor,
    textSize,
    textWeight,
    elevation,
    letterSpacing,
    height,
    child,
    side,
    gapLeadingText,
  ];

  @override
  bool? get stringify => false;
}

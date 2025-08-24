import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';
import '../theme/dimensions.dart';
import '../theme/light_colors.dart';
import '../theme/styles.dart';

class AppFormField extends StatefulWidget {
  const AppFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.focusNode,
    this.textInputAction,
    this.enabled = true,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onSaved,
    this.validator,
    this.borderColor,
    this.validatedText,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.fillColor,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.radius = 36,
    this.obsecureText = false,
    this.readOnly = false,
    this.autofillHints,
    this.contentPadding,
    required this.title,
    this.titleStyle,
    this.hintStyle,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  final TextInputAction? textInputAction;

  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? autofocus;

  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? validatedText;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final AutovalidateMode autovalidateMode;
  final double? radius;
  final bool obsecureText;
  final bool readOnly;
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: widget.titleStyle ?? font14w600),
        5.hSpace,
        TextFormField(
          autofocus: widget.autofocus ?? false,
          enableInteractiveSelection:
              widget.readOnly || widget.enabled == false ? false : true,
          autovalidateMode: AutovalidateMode.disabled,
          readOnly: widget.readOnly,
          autofillHints: widget.autofillHints,
          obscureText: widget.obsecureText,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          onChanged: (value) => setState(() {}),
          enabled: widget.enabled,
          textInputAction: widget.textInputAction,
          validator:
              widget.validator ??
              (value) {
                // if (value?.isNotEmpty == true) {
                //   return 'Enter ${widget.validatedText ?? ''}';
                // }
                return null;
              },

          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          inputFormatters: widget.inputFormatters,
          textAlign: widget.textAlign,
          style: font14w400,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            filled: true,
            fillColor: widget.fillColor,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              minHeight: 24.h,
            ),

            suffixIcon: widget.suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    widget.readOnly == true
                        ? Colors.transparent
                        : AppLightColors.primary,
              ),
              borderRadius: BorderRadius.circular(
                widget.radius ?? AppDimensions.defaultRadius,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              // borderSide: const BorderSide(color: AppColors.opacityBlue),
              borderRadius: BorderRadius.circular(
                widget.radius ?? AppDimensions.defaultRadius,
              ),
              borderSide: BorderSide(
                color:
                    widget.borderColor ??
                    (widget.readOnly == true
                        ? Colors.transparent
                        : AppLightColors.formFieldBorder),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              // borderSide: BorderSide(color:widget.borderColor ?? AppLightColors.formFieldBorder),
              borderRadius: BorderRadius.circular(
                widget.radius ?? AppDimensions.defaultRadius,
              ),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppLightColors.formfiledErrorColor),
              borderRadius: BorderRadius.circular(
                widget.radius ?? AppDimensions.defaultRadius,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    widget.readOnly == true
                        ? Colors.transparent
                        : AppLightColors.formfiledErrorColor,
              ),
              borderRadius: BorderRadius.circular(
                widget.radius ?? AppDimensions.defaultRadius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

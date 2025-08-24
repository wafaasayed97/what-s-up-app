import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:what_s_up_app/generated/l10n.dart';
import '../widgets/app_svg.dart';
import '/core/routes/app_routes.dart';
import '/core/theme/styles.dart';
import '../theme/light_colors.dart';

bool _isLoading = false;

Future<void> showLoading({bool canDismiss = false}) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _isLoading = true;
    final context = navigatorKey!.currentState!.context;

    showDialog(
      context: context,
      barrierDismissible: canDismiss,
      builder: (context) {
        return Center(
          child: SpinKitDualRing(
            color: Theme.of(context).primaryColor,
            size: 50.0,
          ),
        );
      },
    );
  });
}

void hideLoading({bool canDismiss = false}) {
  if (_isLoading) {
    _isLoading = false;
    Navigator.of(navigatorKey!.currentState!.context).pop();
  }
}

void showSuccess(String message, {bool canDismiss = true}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showAlert(
      message: message,
      canDismiss: canDismiss,
      alertType: AlertType.success,
    );
  });
}

void showWarning(String message, {bool canDismiss = true}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showAlert(
      message: message,
      canDismiss: canDismiss,
      alertType: AlertType.warning,
    );
  });
}

void showError(String message, {bool canDismiss = true}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showAlert(
      message: message,
      canDismiss: canDismiss,
      alertType: AlertType.error,
    );
  });
}

enum AlertType { success, warning, error }

void _showAlert({
  required message,
  required bool canDismiss,
  required AlertType alertType,
}) {
  final context = navigatorKey!.currentState!.context;

  String alertImage = '';
  String alertTitle = '';
  Color alertColor = Color(0xFF8BD999);

  if (alertType == AlertType.success) {
    alertImage = 'alert_success';
    alertTitle = S().success;
    alertColor = Color(0xFF8BD999);
  } else if (alertType == AlertType.warning) {
    alertImage = 'alert_warning';
    alertTitle = S().warning;
    alertColor = Color(0xFFEBCB00);
  } else if (alertType == AlertType.error) {
    alertImage = 'alert_error';
    alertTitle = S().error;
    alertColor = Color(0xFFD93434);
  }

  showDialog(
    context: context,
    barrierDismissible: canDismiss,
    barrierColor: Colors.transparent,
    builder: (context) {
      Future.delayed(const Duration(milliseconds: 3500), () {
        context.pop();
      });

      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.h),
            padding: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
              color: AppLightColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0x10182824),
                  spreadRadius: -12,
                  blurRadius: 64,
                  offset: Offset(0, 32),
                ),
              ],
            ),
            child: Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSVG(assetName: alertImage, width: 32.w, height: 32.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: font16w700.copyWith(color: alertColor),
                        child: Text(alertTitle),
                      ),
                      DefaultTextStyle(
                        style: font14w400.copyWith(color: Colors.black),
                        child: Text(message),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

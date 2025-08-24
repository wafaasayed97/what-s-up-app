import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_device/safe_device.dart';
import 'package:what_s_up_app/core/app_cubit/app_cubit.dart';
import 'package:what_s_up_app/core/helpers/helpers.dart';

import '/core/extensions/ext.dart';
import '/core/theme/light_colors.dart';
import '../helpers/safe_print.dart';
import '/core/widgets/app_svg.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/default_app_bar.dart';

class SecurityViolationScreen extends StatefulWidget {
  const SecurityViolationScreen({super.key});

  @override
  State<SecurityViolationScreen> createState() =>
      SsevurityVailoationScreenState();
}

class SsevurityVailoationScreenState extends State<SecurityViolationScreen> {
  List<String> securityVaiolationsMesasges = [];

  int terminationCountdown = 5;

  @override
  initState() {
    super.initState();
    checkSecurityViolations();
    startTerminationCountdown();
  }

  Future<void> checkSecurityViolations() async {
    isRealDevice();

    isJailBroken();

    isMockLocation();

    isOnExternalStorage();

    isAndroidDeveloperModeEnabld();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'securityViolationDetected',
        onBackPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Column(
          spacing: 10,
          children: [
            const AppSVG(assetName: 'alert'),
            Text(
              'securityViolationMsg',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            10.hSpace,
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Text(
                      '`${'securityViolationMsg2'}`',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.all(10.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: securityVaiolationsMesasges.length,
                      itemBuilder: (context, index) {
                        final String message =
                            securityVaiolationsMesasges[index];

                        return Text(
                          '${index + 1} - $message',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 5.hSpace,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            AppButton(text: 'contactUs', onPressed: () => contactUs()),
            AppButton(
              text: '${'exit'} $terminationCountdown',
              onPressed: () => exit(0),
              color: Colors.transparent,
              textColor: AppLightColors.primary,
              borderColor: AppLightColors.primary,
            ),
            20.hSpace,
          ],
        ),
      ),
    );
  }

  void changeLanguage({required String language}) {
    final cubit = BlocProvider.of<AppCubit>(context);

    cubit.changeLanguage(language: language);
  }

  Future<void> isRealDevice() async {
    bool isRealDevice = await SafeDevice.isRealDevice;

    if (!isRealDevice) {
      securityVaiolationsMesasges.add('emulatorDetected');
      setState(() {});
    }
  }

  Future<void> isJailBroken() async {
    bool isJailBroken = await SafeDevice.isJailBroken;

    if (isJailBroken) {
      if (Platform.isAndroid) {
        securityVaiolationsMesasges.add('deviceRooted');
      }
      if (Platform.isIOS) {
        securityVaiolationsMesasges.add('deviceJailbroken');
      }
      setState(() {});
    }
  }

  Future<void> isMockLocation() async {
    if (!Platform.isAndroid) return;

    // Android only & Location permission required
    bool isLocationPermissionGranted = await Permission.location.isGranted;

    bool isMockLocation = await SafeDevice.isMockLocation;

    if (isLocationPermissionGranted && isMockLocation) {
      securityVaiolationsMesasges.add('mockLocationDetected');
      setState(() {});
    }
  }

  void isOnExternalStorage() async {
    if (!Platform.isAndroid) return;

    bool isOnExternalStorage = await SafeDevice.isOnExternalStorage;

    if (isOnExternalStorage) {
      securityVaiolationsMesasges.add('externalStorageDetected');
      setState(() {});
    }
  }

  Future<void> isAndroidDeveloperModeEnabld() async {
    if (!Platform.isAndroid) return;

    bool isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;

    if (isDevelopmentModeEnable) {
      securityVaiolationsMesasges.add('developerModeDetected');
      setState(() {});
    }
  }

  void contactUs() {
    try {
      LauncherHelper.sendMail('support@gmail.com');
    } catch (e) {
      safePrint(e);
    }
  }

  void startTerminationCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (terminationCountdown == 0) {
        timer.cancel();
        exit(0);
      } else {
        setState(() {
          terminationCountdown--;
        });
      }
    });
  }
}

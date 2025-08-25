// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:go_router/go_router.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:what_s_up_app/core/routes/route_paths.dart';
// import 'package:what_s_up_app/generated/l10n.dart';
// import '../helpers/safe_print.dart';

// abstract class IVersionChecker {
//   Future<void> checkAppVersion();
// }

// class VersionChecker implements IVersionChecker {
//   final BuildContext context;
//   final IRemoteConfigService remoteConfigService;
//   final IUpdateDialogService updateDialogService;
//   final INavigationService navigationService;

//   VersionChecker({
//     required this.context,
//     required this.remoteConfigService,
//     required this.updateDialogService,
//     required this.navigationService,
//   });

//   @override
//   Future<void> checkAppVersion() async {
//     try {
//       final remoteValues = await remoteConfigService.fetchConfig();
//       final currentVersion = (await PackageInfo.fromPlatform()).version;

//       final latestVersion =
//           Platform.isAndroid
//               ? remoteValues.androidVersion
//               : remoteValues.iosVersion;

//       final updateRequired = _isUpdateRequired(currentVersion, latestVersion);

//       if (updateRequired) {
//         updateDialogService.showUpdateDialog(
//           context,
//           isCritical: remoteValues.isCritical,
//           onUpdate: _launchStore,
//           onSkip: navigationService.navigate,
//         );
//       } else {
//         navigationService.navigate();
//       }
//     } catch (e) {
//       safePrint("Remote config failed: $e");
//       navigationService.navigate();
//     }
//   }

//   bool _isUpdateRequired(String current, String latest) {
//     final currentList = current.split('.').map(int.parse).toList();
//     final latestList = latest.split('.').map(int.parse).toList();
//     for (int i = 0; i < latestList.length; i++) {
//       if (currentList.length <= i || currentList[i] < latestList[i]) {
//         return true;
//       }
//       if (currentList[i] > latestList[i]) return false;
//     }
//     return false;
//   }

//   void _launchStore() {
//     final url =
//         Platform.isAndroid
//             ? "https://play.google.com/store/apps/details?id=com.cic.tmg.ksa.eservice"
//             : "";
//     launchUrl(Uri.parse(url));
//   }
// }

// class RemoteConfigValues {
//   final String androidVersion;
//   final String iosVersion;
//   final bool isCritical;

//   RemoteConfigValues({
//     required this.androidVersion,
//     required this.iosVersion,
//     required this.isCritical,
//   });
// }

// abstract class IRemoteConfigService {
//   Future<RemoteConfigValues> fetchConfig();
// }

// class FirebaseRemoteConfigService implements IRemoteConfigService {
//   @override
//   Future<RemoteConfigValues> fetchConfig() async {
//     final remoteConfig = FirebaseRemoteConfig.instance;
//     await remoteConfig.setConfigSettings(
//       RemoteConfigSettings(
//         fetchTimeout: const Duration(seconds: 10),
//         minimumFetchInterval: const Duration(seconds: 0),
//       ),
//     );
//     await remoteConfig.fetchAndActivate();

//     return RemoteConfigValues(
//       androidVersion: remoteConfig.getString('andriod_app_version'),
//       iosVersion: remoteConfig.getString('ios_app_version'),
//       isCritical: remoteConfig.getBool('critical'),
//     );
//   }
// }

// abstract class IUpdateDialogService {
//   void showUpdateDialog(
//     BuildContext context, {
//     required bool isCritical,
//     required VoidCallback onUpdate,
//     required VoidCallback onSkip,
//   });
// }

// class CupertinoUpdateDialogService implements IUpdateDialogService {
//   @override
//   void showUpdateDialog(
//     BuildContext context, {
//     required bool isCritical,
//     required VoidCallback onUpdate,
//     required VoidCallback onSkip,
//   }) {
//     showCupertinoDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => CupertinoAlertDialog(
//             title: Text(S.of(context).updateRequired),
//             content: Text(S.of(context).updateRequiredBody),
//             actions: [
//               CupertinoDialogAction(
//                 onPressed: onUpdate,
//                 child: Text(S.of(context).update),
//               ),
//               if (!isCritical)
//                 CupertinoDialogAction(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     onSkip();
//                   },
//                   child: Text(S.of(context).notNow),
//                 ),
//             ],
//           ),
//     );
//   }
// }

// abstract class INavigationService {
//   Future<void> navigate();
// }

// class AuthNavigationService implements INavigationService {
//   final BuildContext context;

//   AuthNavigationService(this.context);

//   @override
//   Future<void> navigate() async {
//     // final token = await sl<SecureStorage>().read(SecureStorageKeys.userToken);
//     // final localAuthEnabled = await sl<SecureStorage>().read(
//     //   SecureStorageKeys.localAuthEnabled,
//     // );

//     // if (localAuthEnabled == 'true') {
//     //   final auth = LocalAuthentication();
//     //   bool didAuthenticate = false;
//     //   int retryCount = 0;
//     //   const maxRetries = 3;

//     //   while (!didAuthenticate && retryCount < maxRetries) {
//     //     try {
//     //       didAuthenticate = await auth.authenticate(
//     //         localizedReason: S.of(context).auth_reason,
//     //         options: const AuthenticationOptions(
//     //           biometricOnly: false,
//     //           stickyAuth: true,
//     //         ),
//     //       );
//     //     } catch (e) {
//     //       debugPrint('Auth error: $e');
//     //     }

       
//     //   }

//     // }
//     safePrint("Navigating to main layout");
//     if (context.mounted) {
//       context.pushReplacement(Routes.mainlayout);
//     }
//   }
// }
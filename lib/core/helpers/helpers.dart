import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart' show SfPdfViewer;
import 'package:url_launcher/url_launcher.dart';
import 'package:what_s_up_app/core/helpers/safe_print.dart';
import '../di/services_locator.dart';
import '../network/network_service.dart';
import '/core/routes/app_routes.dart';
import '/generated/l10n.dart';
import 'alerts.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Helpers {
  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  static Future<List<File>> getImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File?> getImageFromCameraOrDevice() async {
    final ImagePicker picker = ImagePicker();
    File? image;

    await showCupertinoModalPopup(
      context: navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(S().choose_image_source),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  image = File(pickedFile.path);
                }
                Navigator.of(context).pop();
              },
              child: Text(S().gallery),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                final pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  image = File(pickedFile.path);
                }
                Navigator.of(context).pop();
              },
              child: Text(S().camera),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S().cancel),
          ),
        );
      },
    );

    return image;
  }

  static Future<List<File>> pickLimitedImagesWithMaxSize({
    required int maxCount,
    int maxSizeInMB = 5,
  }) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();

    if (result.isEmpty) return [];

    List<File> validFiles = [];

    for (final xfile in result) {
      if (validFiles.length >= maxCount) break;
      final file = File(xfile.path);
      final bytes = await file.length();
      final sizeInMB = bytes / (1024 * 1024);
      if (sizeInMB <= maxSizeInMB) {
        validFiles.add(file);
      }
    }
    return validFiles;
  }

  static void shareApp(url) {
    Share.share(url).whenComplete(() {});
  }

  static Future<File?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  static bool _isPickingFiles = false;

  static Future<List<File>?> pickAnyFiles() async {
    if (_isPickingFiles) return null;

    _isPickingFiles = true;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        return result.paths
            .whereType<String>()
            .map((path) => File(path))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      safePrint('❌ pickAnyFiles error: $e');
      return null;
    } finally {
      _isPickingFiles = false;
    }
  }

  static void showFilePreview(BuildContext context, File file) {
    final mimeType = lookupMimeType(file.path) ?? '';
    final lowerMime = mimeType.toLowerCase();

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        if (lowerMime.startsWith('image/') ||
            lowerMime.contains('jpg') ||
            lowerMime.contains('jpeg') ||
            lowerMime.contains('png') ||
            lowerMime.contains('webp') ||
            lowerMime.contains('gif')) {
          return CupertinoPopupSurface(
            blurSigma: 1.0,
            child: SafeArea(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            file,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(5),
                        child: const Icon(CupertinoIcons.clear),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (lowerMime.contains('pdf') ||
            lowerMime == 'application/pdf') {
          return CupertinoPopupSurface(
            blurSigma: 1.0,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SfPdfViewer.file(file),
                    CupertinoButton(
                      padding: const EdgeInsets.all(5),
                      child: const Icon(CupertinoIcons.clear),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(S().somethingWentWrong),
            content: Text(S().somethingWentWrong),
            actions: [
              CupertinoDialogAction(
                child: Text(S().done),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      },
    );
  }

  static String formatNumberWithCommas({required num value}) {
    return value
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }
}

class LauncherHelper {
  static void launchURL({required String url}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://$url";
    }
    await launchUrl(Uri.parse(url));
  }

  static void launchWhatsApp(String phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    var whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
    debugPrint(whatsAppUrl);
    if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
      await launchUrl(Uri.parse(whatsAppUrl));
    } else {
      throw 'AppStrings.error.tr()';
    }
  }

  static void launchYoutube({required String url}) async {
    final Uri parsedUrl = Uri.parse(url);
    if (Platform.isIOS) {
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      } else {
        if (await canLaunchUrl(parsedUrl)) {
          await launchUrl(parsedUrl);
        } else {
          throw 'Could not launch $parsedUrl';
        }
      }
    } else {
      if (await canLaunchUrl(parsedUrl)) {
        await launchUrl(parsedUrl);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static Future<void> launchTwitter(String userName) async {
    final twitterProfileUrl = Uri.parse(
      'twitter://user?screen_name=$userName',
    ); // Twitter app URL
    final Uri webUrl = Uri.parse('https://twitter.com/$userName'); // Web URL
    try {
      if (await canLaunchUrl(twitterProfileUrl)) {
        await launchUrl(twitterProfileUrl);
      } else {
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl);
        } else {
          throw 'Could not launch Twitter in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchInstagram(String userName) async {
    final Uri instagramProfileUrl = Uri.parse(
      'https://www.instagram.com/$userName',
    ); // Replace with your Instagram profile URL
    final Uri instagramNativeApp = Uri.parse(
      'instagram://user?username=$userName',
    );

    try {
      if (await canLaunchUrl(instagramNativeApp)) {
        await launchUrl(instagramNativeApp); // Open Instagram app
      } else {
        if (await canLaunchUrl(instagramProfileUrl)) {
          await launchUrl(instagramProfileUrl);
        } else {
          throw 'Could not launch Instagram in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void launchFacebook(String userName) async {
    final Uri nativeUrl = Uri.parse(
      'fb://facewebmodal/f?href=https://www.facebook.com/$userName',
    );
    final Uri webUrl = Uri.parse('https://www.facebook.com/$userName');
    if (await canLaunchUrl(nativeUrl)) {
      await launchUrl(nativeUrl);
    } else {
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl);
      } else {
        throw 'Could not launch $webUrl';
      }
    }
  }

  static Future<void> launchSnapchat(String userName) async {
    final snapchatProfileUrl = Uri.parse(
      'https://www.snapchat.com/add/$userName',
    );
    final snapChatNativeApp = Uri.parse('snapchat://add/$userName');

    try {
      if (await canLaunchUrl(snapChatNativeApp)) {
        await launchUrl(snapChatNativeApp);
      } else {
        if (await canLaunchUrl(snapchatProfileUrl)) {
          await launchUrl(snapchatProfileUrl);
        } else {
          throw 'Could not launch Snapchat in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static Future<void> launchTikTok(String userName) async {
    final tiktokProfileUrl = Uri.parse('https://www.tiktok.com/@$userName');

    try {
      if (await canLaunchUrl(Uri.parse('com.zhiliaoapp.musically'))) {
        await launchUrl(
          Uri.parse('com.zhiliaoapp.musically://user?u=$userName'),
        );
      } else {
        if (await canLaunchUrl(tiktokProfileUrl)) {
          await launchUrl(tiktokProfileUrl);
        } else {
          throw 'Could not launch TikTok in a web browser';
        }
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  static void callPhone({phone}) async {
    await launchUrl(Uri.parse('tel:$phone'));
  }

  static void sendMail(mail) async {
    await launchUrl(Uri.parse('mailto:$mail'));
  }

  static Future<void> previewFileById(
    BuildContext context,
    String endpoint,
    String mediaType,
  ) async {
    showLoading();

    try {
      final dio = sl<NetworkService>().dio;

      final response = await dio.get(
        endpoint,
        options: Options(responseType: ResponseType.bytes),
      );

      hideLoading();

      if (response.data == null || (response.data as List).isEmpty) {
        showError('الملف غير متاح أو فاضي');
        return;
      }

      final data = Uint8List.fromList(response.data as List<int>);
      final mime = mediaType.toLowerCase();

      if (mime.startsWith('image/') ||
          mime.contains('jpg') ||
          mime.contains('jpeg') ||
          mime.contains('png') ||
          mime.contains('webp') ||
          mime.contains('gif')) {
        showCupertinoModalPopup(
          context: context,
          builder:
              (_) => CupertinoPopupSurface(
                child: SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(CupertinoIcons.clear),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Expanded(
                        child: ClipRect(
                          child: InteractiveViewer(
                            panEnabled: true,
                            maxScale: 5.0,
                            minScale: 0.5,
                            child: Center(child: Image.memory(data)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      } else if (mime.contains('pdf') || mime == 'application/pdf') {
        bool isEmulator = false;
        try {
          if (Platform.isAndroid) {
            final androidInfo = await DeviceInfoPlugin().androidInfo;
            isEmulator = androidInfo.isPhysicalDevice == false;
          }
        } catch (e) {
          safePrint("device_info error: $e");
          isEmulator = true;
        }

        if (isEmulator) {
          showError('عرض ملفات PDF غير مدعوم على المحاكي');
          return;
        }

        showCupertinoModalPopup(
          context: context,
          builder:
              (_) => CupertinoPopupSurface(
                child: SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(CupertinoIcons.clear),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Expanded(child: SfPdfViewer.memory(data)),
                    ],
                  ),
                ),
              ),
        );
      } else {
        showError('نوع الملف غير مدعوم');
      }
    } catch (e, stackTrace) {
      hideLoading();
      safePrint('previewFileById error: $e');
      safePrint('stackTrace: $stackTrace');
      showError('فشل في تحميل الملف');
    }
  }
}

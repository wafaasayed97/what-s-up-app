import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:what_s_up_app/core/constants/assets_manager.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';
import '/core/di/services_locator.dart';
import '/core/theme/styles.dart';
import '../../generated/l10n.dart';
import '../app_cubit/app_cubit.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import 'app_svg.dart';
import 'bouncing_widgets.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title = "",
    this.enableBack = true,
    this.centerTitle = true,
    this.isHomeScreen = false,
    this.withNotification = false,
    this.withUserImage = false,
    required this.onBackPressed,
    this.elevation,
    this.isGuest = false,
    this.isProfileScreen = false,
  });
  final bool isProfileScreen;

  final String title;
  final bool isGuest;
  final bool enableBack;
  final double? elevation;
  final bool? centerTitle;
  final bool isHomeScreen;
  final bool withNotification;
  final bool withUserImage;
  final VoidCallback? onBackPressed;

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title:
          widget.isHomeScreen
              ? homeAppBar(context)
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.flip(
                    flipX:
                        sl<PreferencesStorage>().getCurrentLanguage() != "en",
                    child: BounceIt(
                      onPressed: widget.onBackPressed,
                      child: AppSVG(
                        assetName: AssetsManager.back,
                        width: 35.w,
                        height: 35.h,
                      ),
                    ),
                  ),
                  10.wSpace,
                  Text(
                    widget.title,
                    style: font18w700.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
      actions: [
        Visibility(
          visible: widget.isHomeScreen || widget.isGuest,
          child: BounceIt(
            onPressed: () {
              context.read<AppCubit>().changeLanguage(
                language:
                    sl<PreferencesStorage>().getCurrentLanguage() == "en"
                        ? "ar"
                        : "en",
              );
            },
            child: AppSVG(
              assetName:
                  sl<PreferencesStorage>().getCurrentLanguage() == "en"
                      ? AssetsManager.ar
                      : AssetsManager.en,
              color: Colors.black,
            ),
          ),
        ),
        10.wSpace,
        // Visibility(
        //   visible: widget.withNotification && widget.isGuest == false,
        //   child: BlocBuilder<NotificationsCubit, NotificationsState>(
        //     builder: (context, state) {
        //       return badges.Badge(
        //         showBadge:
        //             context.read<NotificationsCubit>().countNotification > 0,
        //         stackFit: StackFit.passthrough,
        //         position: badges.BadgePosition.topEnd(top: 0, end: 0),
        //         badgeContent: Text(
        //           context
        //               .read<NotificationsCubit>()
        //               .countNotification
        //               .toString(),
        //           style: font12w500.copyWith(color: Colors.white),
        //         ),
        //         child: BounceIt(
        //           onPressed: () async {
        //             final result = await context.push(
        //               Routes.notificationsScreen,
        //             );
        //             if (result == true) {
        //               context
        //                   .read<NotificationsCubit>()
        //                   .getUnseenNotifications();
        //             }
        //           },
        //           child: AppSVG(assetName: AssetsManager.notifications),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        10.wSpace,
        Visibility(
          visible: widget.withUserImage,
          child: Row(
            children: [
              // BounceIt(
              //   onPressed: () {
              //     if (widget.isProfileScreen == false) {
              //       safePrint("push");
              //       context.push(Routes.myProfileScreen);
              //     }
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //     ),
              //     child: AuthNetworkImage(
              //       borderRadius: 50.bRadius,
              //       height: 35.h,
              //       width: 35.w,
              //       imageUrl: sl<PreferencesStorage>()
              //           .getString(
              //         key: PreferencesKeys.picture,
              //       ),
              //     ),
              //   ),
              // ),
              15.wSpace,
            ],
          ),
        ),
      ],
    );
  }

  homeAppBar(context) {
    return Row(
      children: [
        // BounceIt(
        //   onPressed: () {
        //     if (widget.isProfileScreen == false) {
        //       GoRouter.of(context).push(Routes.myProfileScreen);
        //     }
        //   },
          // child: Container(
          //   decoration: BoxDecoration(shape: BoxShape.circle),
          //   child: AuthNetworkImage(
          //     borderRadius: 50.bRadius,
          //     height: 35.h,
          //     width: 35.w,
          //     imageUrl: sl<PreferencesStorage>().getString(
          //       key: PreferencesKeys.picture,
          //     ),
          //   ),
          // ),
       // ),
        10.wSpace,
       
      ],
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return S().chats;
      case 1:
        return S().update;
      case 2:
        return S().communities;
      case 3:
        return S().calls;
      
      default:
        return S().chats;
    }
  }

 
}

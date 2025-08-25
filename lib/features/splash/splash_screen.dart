import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:what_s_up_app/core/routes/route_paths.dart';
import 'package:what_s_up_app/core/widgets/app_asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    animate().then((onValue) {
      Future.delayed(const Duration(seconds: 1)).then((onValue) {
        context.pushReplacement(Routes.mainlayout);
      });
    });
  }

  Future animate() async {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: AppAsset(
            assetName: 'assets/images/WhatsApp.svg.webp',
            height: 200.h,
            width: 200.w,
          ),
        ),
      ),
    );
  }
}

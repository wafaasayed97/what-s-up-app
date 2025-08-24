import 'package:flutter/material.dart';

class AppAsset extends StatelessWidget {
  const AppAsset({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.borderRadius,
  });

  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    String assetPath = assetName;
    if (!assetPath.contains('assets')) {
      assetPath = "assets/images/$assetPath.png";
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        assetPath,
        height: height,
        width: width,
        color: color,
        fit: fit,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PopCurve extends Curve {
  const PopCurve();

  @override
  double transform(double t) {
    return 4 * t * (1 - t);
  }
}
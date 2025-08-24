import 'dart:core';
import 'package:flutter/material.dart';

class BottomNavigationBarModel {
  List<Text> appBarTitles;
  List<Widget> unselectedIcons;
  List<Widget> selectedIcons;

  BottomNavigationBarModel({
    required this.appBarTitles,
    required this.unselectedIcons,
    required this.selectedIcons,
  });
}
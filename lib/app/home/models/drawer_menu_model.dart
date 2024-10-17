import 'package:flutter/material.dart';

class DrawerMenuModel {
  late String name;
  late IconData? iconData;
  late Function onTap;
  bool isActive;

  DrawerMenuModel(
      {required this.name,
      this.iconData,
      required this.onTap,
      this.isActive = false});
}

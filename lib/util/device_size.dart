import 'dart:ui';

import 'package:flutter/material.dart';

class DeviceSize {
  static double get width => MediaQueryData.fromView(window).size.width;
  static double get height => MediaQueryData.fromView(window).size.height;
}

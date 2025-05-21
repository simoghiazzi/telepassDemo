import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Enables mouse drag scrolling for desktop/web platforms.
class DesktopScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  };
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// This class is used to enable scrolling on web with a mouse.
class AppScrollBehaviorWebExtended extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

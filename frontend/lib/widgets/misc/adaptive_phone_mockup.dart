import 'package:flutter/material.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:frontend/widgets/misc/backgrounds/blobs_background.dart';
import 'package:frontend/widgets/misc/backgrounds/ink_splash_background.dart';

class AdaptivePhoneMockup extends StatelessWidget {
  final Widget childWidget;
  static const double maxMobileWidth = 600.0;
  double screenW = 0;
  double screenH = 0;

  AdaptivePhoneMockup({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > maxMobileWidth;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    if (isWideScreen) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            InkSplatterBackground(
              x: screenW / 8,
              y: screenH / 8,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 55.0),
                child: DeviceFrame(
                  device: Devices.ios.iPhone13ProMax,
                  isFrameVisible: true,
                  orientation: Orientation.portrait,
                  screen: Builder(
                    builder: (deviceContext) => MaterialApp(
                      theme: Theme.of(context),
                      home: childWidget,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return childWidget;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:frontend/pages/app_page.dart';
import 'package:frontend/widgets/misc/backgrounds/blobs_background.dart';
import 'package:frontend/widgets/misc/backgrounds/ink_splash_background.dart';
import 'package:frontend/widgets/tutorials/welcome_modal.dart';

class AdaptivePhoneMockup extends StatelessWidget {
  static const double maxMobileWidth = 600.0;
  double screenW = 0;
  double screenH = 0;

  AdaptivePhoneMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > maxMobileWidth;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final showModal = screenW < 1500 || screenH < 600;

    if (isWideScreen) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            InkSplatterBackground(),
            if (!showModal) Positioned(
                left: 100,
                top: (screenH - 200) / 2,
                child: const WelcomeContent(
                  isManager: true,
                )),
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
                      home: AppPage(showModal: showModal),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return AppPage(showModal: showModal);
    }
  }
}

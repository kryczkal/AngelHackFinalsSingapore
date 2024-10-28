import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/app_page.dart';
import 'package:frontend/widgets/misc/adaptive_phone_mockup.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppEventsSingleton()),
    ChangeNotifierProvider(create: (context) => AppUserSingleton()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ColorScheme customColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF66BB6A),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF426a20),
      onSecondary: Color(0xFFFFFFFF),
      tertiary: Color(0xFFd5eeba),
      onTertiary: Color(0xFF272727),
      error: Color(0xFFff5963),
      onError: Color(0xFFFFFFFF),
      surface: Colors.white,
      onSurface: Color(0xFF272727),
    );

    return MaterialApp(
      title: 'LyfTogether',
      scrollBehavior: ScrollBehaviorWebExtended(),
      theme: ThemeData(
        colorScheme: customColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: ShowCaseWidget(builder: (context) => AdaptivePhoneMockup()),
    );
  }
}

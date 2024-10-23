import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/pages/app_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppEventsSingleton(),
      child: const MyApp(),
    ),
  );
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
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF272727),
      surface: Color(0xFFf2f2f2),
      onSurface: Color(0xFF272727),
    );

    return MaterialApp(
        title: 'Meal Details',
        theme: ThemeData(
          colorScheme: customColorScheme,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const AppPage());
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/pages/all_events_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme customColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF86c144),
      onPrimary: Color(0xFF272727),
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
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Events'),
            ),
            body: const AllEventsPage()));
  }
}

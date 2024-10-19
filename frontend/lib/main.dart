import 'package:flutter/material.dart';
import 'package:frontend/profile/profile.dart'; // Import the ProfileWidget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a custom color scheme
    final ColorScheme customColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF86c144),
      onPrimary: Color(0xFF272727), // Assuming black text on primary color
      secondary: Color(0xFF426a20),
      onSecondary: Color(0xFFFFFFFF), // Assuming white text on secondary color
      tertiary: Color(0xFFd5eeba),
      onTertiary: Color(0xFF272727), // Assuming black text on tertiary color
      error: Color(0xFFff5963),
      onError: Color(0xFFFFFFFF), // Assuming white text on error color
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF272727),
      surface: Color(0xFFf2f2f2),
      onSurface: Color(0xFF272727),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: customColorScheme,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '0',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileWidget(),
                  ),
                );
              },
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

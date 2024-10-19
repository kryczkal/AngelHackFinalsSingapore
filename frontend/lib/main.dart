import 'package:flutter/material.dart';
import 'package:frontend/pages/EventDetailsPage.dart';

// Define the main entry point of the app
void main() {
  runApp(MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Details',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventDetailsPage(eventName: 'Yoga session'), // Set the home page to MealDetailsPage
    );
  }
}
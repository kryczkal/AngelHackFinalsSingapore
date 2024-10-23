import 'package:flutter/material.dart';
import 'package:frontend/pages/manager_dashboard_page.dart';
import 'package:frontend/pages/user_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          UserPage(),
          ManagerDashboardPage(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

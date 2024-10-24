import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/manager_dashboard_page.dart';
import 'package:frontend/pages/user_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isManager = AppUserSingleton().currentUser.isManager;

    return Scaffold(
      body: PageView(
        children: isManager
            ? const [
                UserPage(),
                ManagerDashboardPage(),
              ]
            : const [
                UserPage(),
              ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

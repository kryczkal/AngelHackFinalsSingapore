import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/manager_dashboard_page.dart';
import 'package:frontend/pages/user_home_page.dart';
import 'package:frontend/widgets/misc/app_scroll_behavior_web_extended.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isManager = AppUserSingleton().currentUser.isManager;

    return Scaffold(
      body: PageView(
        scrollBehavior: AppScrollBehaviorWebExtended(),
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

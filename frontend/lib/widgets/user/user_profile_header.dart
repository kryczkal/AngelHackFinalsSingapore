import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/profile/user_profile_brief_page.dart';
import 'package:frontend/widgets/misc/show_case_wrapper_widget.dart';
import 'package:showcaseview/showcaseview.dart';

class ProfileHeader extends StatelessWidget {
  final bool hasNotification;
  final GlobalKey? showKey;
  final bool showProfile;

  const ProfileHeader(
      {super.key,
      this.hasNotification = false,
      this.showKey,
      this.showProfile = true});

  Widget _buildUserIcon(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        radius: 20.0,
        backgroundImage: AssetImage(AppUserSingleton().profileImagePath),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                UserProfileBrief(user: AppUserSingleton().currentUser),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${AppUserSingleton().currentUser.firstName}',
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  AppUserSingleton().currentLocation,
                  style: TextStyle(
                    fontSize: 17.5,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (showProfile)
          Stack(
            children: [
              if (showKey != null)
                ShowcaseWrapper(
                    showcaseKey: showKey!,
                    title: "Check User Profile!",
                    description:
                        "User may enter preferred categories and change settings!",
                    child: _buildUserIcon(context))
              else
                _buildUserIcon(context),
              if (hasNotification)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  final bool hasNotification;
  const ProfileHeader({
    super.key,
    this.hasNotification = false,
  });

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
        Stack(
          children: [
            IconButton(
              icon: CircleAvatar(
                radius: 20.0,
                backgroundImage:
                    AssetImage(AppUserSingleton().profileImagePath),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        UserProfile(user: AppUserSingleton().currentUser),
                  ),
                );
              },
            ),
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

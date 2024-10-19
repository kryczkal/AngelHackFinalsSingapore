import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_user.dart';
import 'package:frontend/profile/profile.dart';

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
              'Hi, ${MockUser().currentUser.firstName}',
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  MockUser().currentLocation,
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
                backgroundImage: AssetImage(MockUser().profileImagePath),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileWidget(),
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

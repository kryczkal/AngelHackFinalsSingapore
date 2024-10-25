import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/user_data.dart';
import 'package:frontend/pages/profile/user_profile_menu_page.dart';
import 'package:frontend/widgets/common/minimum_app_bar.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';
import 'package:frontend/widgets/user/user_preferences_wrap_widget.dart';

class UserProfileBrief extends StatefulWidget {
  final User user;

  const UserProfileBrief({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileBriefState createState() => _UserProfileBriefState();
}

class _UserProfileBriefState extends State<UserProfileBrief> {
  List<Widget> getBadges() {
    List<Widget> badgesBlocks = widget.user.userBadges
        .map((badge) => _buildTab(badge.name, isSelected: true))
        .toList();
    if (badgesBlocks.isEmpty) {
      badgesBlocks.add(const Text('None'));
    }
    return badgesBlocks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MinimumAppBar(
        actions: [
          if (widget.user == AppUserSingleton().currentUser)
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserProfileMenu(),
                  ),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollViewWebExtended(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFEBEE),
                      shape: BoxShape.circle,
                    ),
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        AssetImage(widget.user.profilePic),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.user.firstName} ${widget.user.lastName}, ${widget.user.age}',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  // Verified Icon
                  const Icon(
                    Icons.verified,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (widget.user.bio != null && widget.user.bio!.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.user.bio!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30),
              const Text(
                'User\'s badges:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: getBadges(),
              ),
              const SizedBox(height: 30),
              const Text(
                'User\'s preferences:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              UserPreferencesWrapWidget(user: widget.user),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTab(String text, {required bool isSelected}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    decoration: BoxDecoration(
      color: isSelected ? Colors.black : Colors.white,
      borderRadius: BorderRadius.circular(30.0),
      border: Border.all(
        color: isSelected ? Colors.black : Colors.grey,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 14.0,
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:frontend/pages/profile/user_profile_edit_page.dart';
import 'package:frontend/pages/events/user_update_preferences_page.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';

// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({super.key});

  // Placeholder for company information
  final String companyName = 'Your Company';
  final String companyBio = 'This is your company bio.';
  final String companyEmail = 'contact@yourcompany.com';
  final String companyPhone = '+1234567890';
  final String appleStoreURL = 'https://apple.com';
  final String playStoreURL = 'https://play.google.com';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollViewWebExtended(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting Section

                // const SizedBox(height: 24),
                // // Thank You Container

                const SizedBox(height: 12),
                // Profile Options
                Column(
                  children: [
                    _buildListTile(
                      context,
                      icon: Icons.person_outline_rounded,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      }, // Changed to do nothing
                    ),
                    _buildListTile(
                      context,
                      icon: Icons.people_alt,
                      title: 'Activity Preferences',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const UserUpdatePreferencesPage(),
                          ),
                        );
                      }, // Changed to do nothing
                    ),
                    if (companyName.isNotEmpty && companyBio.isNotEmpty)
                      _buildListTile(
                        context,
                        icon: Icons.info_outlined,
                        title: 'About Us',
                        onTap: () {}, // Changed to do nothing
                      ),
                    _buildListTile(
                      context,
                      icon: Icons.support_agent,
                      title: 'Support Center',
                      onTap: () {}, // Changed to do nothing
                    ),
                    if (companyEmail.isNotEmpty || companyPhone.isNotEmpty)
                      _buildListTile(
                        context,
                        icon: Icons.mail_outlined,
                        title: 'Contact Us',
                        onTap: () {}, // Changed to do nothing
                      ),
                    if (appleStoreURL.isNotEmpty || playStoreURL.isNotEmpty)
                      _buildListTile(
                        context,
                        icon: Icons.share_outlined,
                        title: 'Share Lyf App',
                        onTap: () {}, // Changed to do nothing
                      ),
                    if (appleStoreURL.isNotEmpty || playStoreURL.isNotEmpty)
                      _buildListTile(
                        context,
                        icon: Icons.star_border_rounded,
                        title: 'Review in the App Store',
                        onTap: () {}, // Changed to do nothing
                      ),
                    _buildListTile(
                      context,
                      icon: Icons.logout,
                      title: 'Log out',
                      onTap: () {}, // Changed to do nothing
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build list tiles
  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 4.0), // Padding before the divider
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                icon,
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary, // Changed to onPrimary for better contrast
                size: 20,
              ),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: onTap,
          ),
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(vertical: 4.0), // Padding after the divider
          child: Divider(
            thickness: 1,
            height: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

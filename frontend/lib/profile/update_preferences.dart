import 'package:flutter/material.dart';

class UpdatePreferencesWidget extends StatefulWidget {
  const UpdatePreferencesWidget({Key? key}) : super(key: key);

  @override
  State<UpdatePreferencesWidget> createState() =>
      _UpdatePreferencesWidgetState();
}

class _UpdatePreferencesWidgetState extends State<UpdatePreferencesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Use colors from the custom color scheme
    final primaryColor = Theme.of(context).colorScheme.primary;
    final infoColor = Theme.of(context).colorScheme.secondary;
    final backgroundColor = Theme.of(context).colorScheme.background;
    final accent1 = Theme.of(context).colorScheme.tertiary;
    final accent2 = Theme.of(context).colorScheme.secondary;
    final accent3 = Theme.of(context).colorScheme.primary;
    final accent4 = Theme.of(context).colorScheme.error;
    final primaryText = Theme.of(context).colorScheme.onBackground;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: infoColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  // Implement save functionality here
                  print('Save button pressed');
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Add Preferences button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: primaryColor,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Add Preferences',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Preferences',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: primaryText,
                            ),
                          ),
                          SizedBox(height: 16),
                          ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              PreferenceItem(
                                icon: Icons.pool,
                                iconColor: Theme.of(context).colorScheme.onPrimary,
                                backgroundColor: accent1,
                                title: 'Swimming',
                                subtitle: 'Water-based exercise',
                                onDelete: () {
                                  print('Delete Swimming');
                                },
                              ),
                              SizedBox(height: 16),
                              PreferenceItem(
                                icon: Icons.terrain,
                                iconColor: primaryColor,
                                backgroundColor: accent1,
                                title: 'Climbing',
                                subtitle: 'Indoor or outdoor climbing',
                                onDelete: () {
                                  print('Delete Climbing');
                                },
                              ),
                              SizedBox(height: 16),
                              PreferenceItem(
                                icon: Icons.sports_soccer,
                                iconColor: primaryColor,
                                backgroundColor: accent1,
                                title: 'Soccer',
                                subtitle: 'Team sport',
                                onDelete: () {
                                  print('Delete Soccer');
                                },
                              ),
                              SizedBox(height: 16),
                              PreferenceItem(
                                icon: Icons.self_improvement,
                                iconColor: primaryColor,
                                backgroundColor: accent1,
                                title: 'Meditation',
                                subtitle: 'Mindfulness practice',
                                onDelete: () {
                                  print('Delete Meditation');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PreferenceItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onDelete;

  const PreferenceItem({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.orange,
            size: 24,
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}

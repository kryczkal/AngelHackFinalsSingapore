import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/app_data/app_animations.dart';
import 'package:frontend/app_data/app_event_templates.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_template.dart';
import 'package:frontend/pages/events/event_create_page.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';

class EventTemplatePage extends StatelessWidget {
  EventTemplatePage({super.key});

  final AppUserSingleton _userSingleton = AppUserSingleton();
  final EventTemplatesSingleton _templatesSingleton = EventTemplatesSingleton();

  @override
  Widget build(BuildContext context) {
    final templates = _templatesSingleton.getTemplatesForUser(
      _userSingleton.currentUser.preferences,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Choose Event Template',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2D3748)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ScrollConfiguration(
          behavior: ScrollBehaviorWebExtended(),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              return _buildTemplateCard(
                context,
                templates[index],
                index,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateCard(
      BuildContext context, EventTemplate template, int index) {
    final primaryColor = Theme.of(context).primaryColor;

    return Hero(
      tag: 'template-${template.name}',
      child: Material(
        child: TweenAnimationBuilder(
          duration: Duration(
              milliseconds: AppAnimations.defaultDurationMs + (index * 100)),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: Card(
            elevation: 2,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEventPage(
                      initialEventTitle: template.prefilledTitle,
                      initialEventDescription: template.prefilledDescription,
                      initialCategory: template.category,
                      initialBadge: template.defaultBadge,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: primaryColor.withOpacity(0.08),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: FaIcon(
                              template.icon,
                              size: 32,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            template.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            template.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF718096),
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (template.isPersonalized)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'For You',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

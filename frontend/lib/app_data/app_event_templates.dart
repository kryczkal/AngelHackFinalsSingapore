import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/app_data/app_badges.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_template.dart';

class EventTemplatesSingleton extends ChangeNotifier {
  static final EventTemplatesSingleton _instance =
      EventTemplatesSingleton._internal();

  factory EventTemplatesSingleton() => _instance;

  EventTemplatesSingleton._internal();

  final List<EventTemplate> _baseTemplates = [
    EventTemplate(
      name: 'Blank Event',
      icon: FontAwesomeIcons.file,
      description: 'Start from scratch with a blank template',
      category: EventCategory.all,
    ),
    EventTemplate(
      name: 'Tech Meetup',
      icon: FontAwesomeIcons.laptop,
      description: 'Perfect for technology discussions and presentations',
      category: EventCategory.technology,
      prefilledTitle: 'Tech Meetup: ',
      prefilledDescription:
          'Join us for an engaging tech meetup where we\'ll discuss the latest developments in technology. Share your insights and connect with fellow tech enthusiasts.',
      defaultBadge: AppBadgesSingleton().possibleBadges[0],
      imageUrl: 'images/events/templates/tech-meetup.jpg',
    ),
    EventTemplate(
      name: 'Networking Dinner',
      icon: FontAwesomeIcons.userGroup,
      description: 'Business networking event with dinner',
      category: EventCategory.networking,
      prefilledTitle: 'Networking Dinner: ',
      prefilledDescription:
          'Connect with professionals over dinner in a relaxed atmosphere. Expand your network while enjoying good food and meaningful conversations.',
      imageUrl: 'images/events/templates/networking-dinner.jpeg',
    ),
    EventTemplate(
      name: 'AI Workshop',
      icon: FontAwesomeIcons.robot,
      description: 'AI and machine learning focused event',
      category: EventCategory.artificialIntelligence,
      prefilledTitle: 'AI Workshop: ',
      prefilledDescription:
          'Deep dive into artificial intelligence concepts and applications. Learn about the latest AI trends and practical implementations.',
      imageUrl: 'images/events/templates/ai-workshop.webp',
    ),
    EventTemplate(
      name: 'Sports Match',
      icon: FontAwesomeIcons.futbol,
      description: 'Sports match or game meetup',
      category: EventCategory.sports,
      prefilledTitle: 'Sports Match: ',
      prefilledDescription:
          'Join us for an exciting sports match. Whether you\'re a player or spectator, come enjoy the game and meet fellow sports enthusiasts.',
      imageUrl: 'images/events/templates/sports-match.webp',
    ),
    EventTemplate(
      name: 'Art Exhibition',
      icon: FontAwesomeIcons.paintbrush,
      description: 'Art showcase or exhibition',
      category: EventCategory.art,
      prefilledTitle: 'Art Exhibition: ',
      prefilledDescription:
          'Experience amazing artworks and meet local artists. Immerse yourself in creativity and artistic expression.',
      imageUrl: 'images/events/templates/art-exhibition.jpg',
    ),
  ];

  List<EventTemplate> getTemplatesForUser(Set<EventCategory> userPreferences) {
    List<EventTemplate> templates = List.from(_baseTemplates);

    templates.removeWhere((template) => template.category == EventCategory.all);
    templates.insert(0, _baseTemplates[0]);

    return templates;
  }
}

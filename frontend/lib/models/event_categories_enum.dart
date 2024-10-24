import 'package:flutter/material.dart';

enum EventCategory {
  all,
  technology,
  finance,
  waterSports,
  music,
  food,
  alcohol,
  sports,
  art,
  fashion,
  health,
  beauty,
  travel,
  networking,
  education,
  motorsports,
  gaming,
  artificialIntelligence,
  engineering,
  science,
  environment,
  politics,
  business,
}

/* map of icons for each category */
final Map<EventCategory, IconData> categoryIcons = {
  EventCategory.all: Icons.apps,
  EventCategory.technology: Icons.computer,
  EventCategory.finance: Icons.attach_money,
  EventCategory.waterSports: Icons.water,
  EventCategory.music: Icons.music_note,
  EventCategory.food: Icons.restaurant,
  EventCategory.alcohol: Icons.local_bar,
  EventCategory.sports: Icons.sports,
  EventCategory.art: Icons.palette,
  EventCategory.fashion: Icons.shopping_bag,
  EventCategory.health: Icons.health_and_safety,
  EventCategory.beauty: Icons.spa,
  EventCategory.travel: Icons.flight,
  EventCategory.networking: Icons.people,
  EventCategory.education: Icons.school,
  EventCategory.motorsports: Icons.sports_motorsports,
  EventCategory.gaming: Icons.sports_esports,
  EventCategory.artificialIntelligence: Icons.psychology,
  EventCategory.engineering: Icons.engineering,
  EventCategory.science: Icons.science,
  EventCategory.environment: Icons.eco,
  EventCategory.politics: Icons.gavel,
};

extension CategoryIconExtension on EventCategory {
  IconData get icon => categoryIcons[this] ?? Icons.help_outline;
}

import 'package:flutter/material.dart';
import 'package:frontend/models/badge_data.dart';
import 'package:frontend/models/event_categories_enum.dart';

class EventTemplate {
  final String name;
  final IconData icon;
  final String description;
  final EventCategory category;
  final String? prefilledTitle;
  final String? prefilledDescription;
  final BadgeData? defaultBadge;
  final bool isPersonalized;
  final String? imageUrl;

  EventTemplate({
    required this.name,
    required this.icon,
    required this.description,
    required this.category,
    this.prefilledTitle,
    this.prefilledDescription,
    this.defaultBadge,
    this.isPersonalized = false,
    this.imageUrl,
  });

  EventTemplate copyWith({
    String? name,
    IconData? icon,
    String? description,
    EventCategory? category,
    String? prefilledTitle,
    String? prefilledDescription,
    BadgeData? defaultBadge,
    bool? isPersonalized,
  }) {
    return EventTemplate(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      category: category ?? this.category,
      prefilledTitle: prefilledTitle ?? this.prefilledTitle,
      prefilledDescription: prefilledDescription ?? this.prefilledDescription,
      defaultBadge: defaultBadge ?? this.defaultBadge,
      isPersonalized: isPersonalized ?? this.isPersonalized,
    );
  }
}

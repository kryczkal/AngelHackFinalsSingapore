import 'package:flutter/material.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_categories_enum.dart';

class EventTemplate {
  final String name;
  final IconData icon;
  final String description;
  final EventCategory category;
  final String? prefilledTitle;
  final String? prefilledDescription;
  final EventBadge? defaultBadge;
  final bool isPersonalized;

  EventTemplate({
    required this.name,
    required this.icon,
    required this.description,
    required this.category,
    this.prefilledTitle,
    this.prefilledDescription,
    this.defaultBadge,
    this.isPersonalized = false,
  });

  EventTemplate copyWith({
    String? name,
    IconData? icon,
    String? description,
    EventCategory? category,
    String? prefilledTitle,
    String? prefilledDescription,
    EventBadge? defaultBadge,
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

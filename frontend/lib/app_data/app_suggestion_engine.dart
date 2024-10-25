import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/user_data.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class AppSugestionEngine {
  static final AppSugestionEngine _instance = AppSugestionEngine._internal();
  final Random _random = Random();

  factory AppSugestionEngine() => _instance;
  AppSugestionEngine._internal();

  // Personalization weights
  static const double PREFERENCE_WEIGHT = 0.4;
  static const double HISTORY_WEIGHT = 0.3;
  static const double LOCATION_WEIGHT = 0.2;
  static const double TIME_WEIGHT = 0.1;

  String getPersonalizedHint(Event event, User user, {DateTime? currentTime}) {
    currentTime ??= DateTime.now();

    // Calculate personalization score
    double score = _calculatePersonalizationScore(event, user);

    // Build suggestion pools
    List<String> suggestions = [];

    // Add preference-based suggestions
    if (user.preferences.contains(event.category)) {
      suggestions.addAll(_getPreferenceBasedSuggestions(event, user));
    }

    // Add history-based suggestions
    if (user.registeredEvents.any((e) => e.category == event.category)) {
      suggestions.addAll(_getHistoryBasedSuggestions(event, user));
    }

    // Add badge-based suggestions
    if (event.badges.any((badge) => user.userBadges.contains(badge))) {
      suggestions.addAll(_getBadgeBasedSuggestions(event, user));
    }

    // Add location-based suggestions
    if (user.location == event.hotel.toString()) {
      suggestions.addAll(_getLocationBasedSuggestions(event));
    }

    // Add category-specific creative suggestions
    suggestions.addAll(_getCategorySpecificSuggestions(event.category));

    // If no specific suggestions were generated, use backup suggestions
    if (suggestions.isEmpty) {
      suggestions = _getBackupSuggestions(event);
    }

    // Randomly select a suggestion, weighted by personalization score
    return suggestions[_random.nextInt(suggestions.length)];
  }

  double _calculatePersonalizationScore(Event event, User user) {
    double score = 0.0;

    // Preference match
    if (user.preferences.contains(event.category)) {
      score += PREFERENCE_WEIGHT;
    }

    // Historical engagement
    if (user.registeredEvents.any((e) => e.category == event.category)) {
      score += HISTORY_WEIGHT;
    }

    // Location proximity
    if (user.location == event.hotel.toString()) {
      score += LOCATION_WEIGHT;
    }

    return score;
  }

  List<String> _getPreferenceBasedSuggestions(Event event, User user) {
    return [
      "This matches your passion for ${event.category.name.toLowerCase()}!",
      "We thought you'd love this ${event.category.name.toLowerCase()} event",
      "Curated just for you based on your interests",
      "This aligns perfectly with your preferences",
      "An event tailored to your ${event.category.name.toLowerCase()} interests",
      "You won't want to miss this ${event.category.name.toLowerCase()} event",
      "Perfect for your ${event.category.name.toLowerCase()} enthusiasm",
      "A great fit for your ${event.category.name.toLowerCase()} passion",
      "Handpicked for your love of ${event.category.name.toLowerCase()}",
      "An ideal event for a ${event.category.name.toLowerCase()} aficionado like you",
    ];
  }

  List<String> _getHistoryBasedSuggestions(Event event, User user) {
    return [
      "Based on your amazing experience at past events",
      "You seemed to enjoy similar events before",
      "Continue your journey in ${event.category.name.toLowerCase()}",
      "Another great addition to your ${event.category.name.toLowerCase()} adventures",
      "Relive the excitement of your previous ${event.category.name.toLowerCase()} events",
      "Your past ${event.category.name.toLowerCase()} experiences suggest you'll love this",
      "Building on your previous ${event.category.name.toLowerCase()} interests",
      "A perfect follow-up to your past ${event.category.name.toLowerCase()} activities",
      "Keep the momentum going with this ${event.category.name.toLowerCase()} event",
      "Your history with ${event.category.name.toLowerCase()} events makes this a great choice",
    ];
  }

  List<String> _getBadgeBasedSuggestions(Event event, User user) {
    return [
      "Perfect for a ${event.badges.first.name} badge holder like you",
      "Show off your ${event.badges.first.name} expertise",
      "Connect with fellow ${event.badges.first.name} enthusiasts",
      "Your ${event.badges.first.name} badge makes this a must-attend",
      "Celebrate your ${event.badges.first.name} achievements",
      "Join others who share your ${event.badges.first.name} badge",
      "Your ${event.badges.first.name} badge unlocks this opportunity",
      "A special event for ${event.badges.first.name} badge holders",
      "Your ${event.badges.first.name} badge is your ticket to this event",
      "Exclusive for ${event.badges.first.name} badge holders like you",
    ];
  }

  List<String> _getLocationBasedSuggestions(Event event) {
    return [];
  }

  List<String> _getCategorySpecificSuggestions(EventCategory category) {
    switch (category) {
      case EventCategory.technology:
        return [
          "Dive into the future of tech",
          "Connect with fellow innovators",
          "Stay ahead of the tech curve",
        ];
      case EventCategory.waterSports:
        return [
          "Make a splash with this exciting activity",
          "Ride the waves of adventure",
          "The perfect water escape awaits",
        ];
      case EventCategory.artificialIntelligence:
        return [
          "Explore the frontiers of AI",
          "Join the AI revolution",
          "Shape the future of intelligence",
        ];
      case EventCategory.food:
        return [
          "Treat your taste buds to something special",
          "A feast for all your senses",
          "Join fellow food enthusiasts",
        ];
      case EventCategory.gaming:
        return [
          "Level up your gaming experience",
          "Join the ultimate gaming adventure",
          "Power up with fellow gamers",
        ];
      // Add more categories as needed
      default:
        return [
          "Discover something extraordinary",
          "Join this exciting experience",
          "Create memorable moments",
        ];
    }
  }

  List<String> _getBackupSuggestions(Event event) {
    return [
      "This event is gaining popularity",
      "Join others in this unique experience",
      "Discover something new and exciting",
      "Perfect for adventurous spirits",
    ];
  }

  // Extension method for category icons with fallback
  IconData getCategoryIcon(EventCategory category) {
    return categoryIcons[category] ?? Icons.event;
  }
}

// Helper extension for more readable category names
extension CategoryNameFormat on EventCategory {
  String get formattedName {
    return name
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim()
        .toLowerCase()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

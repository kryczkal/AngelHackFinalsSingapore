import 'package:frontend/models/badge_data.dart';

class AppBadgesSingleton {
  static final AppBadgesSingleton _instance = AppBadgesSingleton._internal();

  factory AppBadgesSingleton() => _instance;

  AppBadgesSingleton._internal();

  final List<BadgeData> possibleBadges =
      BadgeEnum.values.map((badge) => badge.badge).toList();

  List<BadgeData> get definedBadges {
    return possibleBadges;
  }
}

import 'package:frontend/models/event_badge.dart';

class AppBadgesSingleton {
  static final AppBadgesSingleton _instance = AppBadgesSingleton._internal();

  factory AppBadgesSingleton() => _instance;

  AppBadgesSingleton._internal();

  final List<EventBadge> possibleBadges = [EventBadge(name: 'Yoga Lover'), EventBadge(name: 'MasterChef')];

  List<EventBadge> get definedBadges {
    return possibleBadges;
  }
}

import 'package:frontend/models/event_categories_enum.dart';

class BadgeData {
  final String name;
  final int level;

  const BadgeData({required this.name, this.level = 1});
}

enum BadgeEnum {
  // Event participation badges
  yogaLover(badge: BadgeData(name: 'Yoga Lover')),
  foodie(badge: BadgeData(name: 'Foodie')),
  techEnthusiast(badge: BadgeData(name: 'Tech Enthusiast')),
  sportsChampion(badge: BadgeData(name: 'Sports Champion')),
  artExplorer(badge: BadgeData(name: 'Art Explorer')),
  poolPartyPro(badge: BadgeData(name: 'Pool Party Pro')),
  wellnessWarrior(badge: BadgeData(name: 'Wellness Warrior')),
  sustainabilityHero(badge: BadgeData(name: 'Sustainability Hero')),
  networkingNinja(badge: BadgeData(name: 'Networking Ninja')),
  musicMaestro(badge: BadgeData(name: 'Music Maestro')),

  // Social engagement badges
  eventOrganizer(badge: BadgeData(name: 'Event Organizer')),
  communityBuilder(badge: BadgeData(name: 'Community Builder')),
  socialButterfly(badge: BadgeData(name: 'Social Butterfly')),

  // Special event badges
  halloweenSpirit(badge: BadgeData(name: 'Halloween Spirit')),
  bubbleMaster(badge: BadgeData(name: 'Bubble Master')),
  payItForwardChampion(badge: BadgeData(name: 'Pay It Forward Champion')),

  // Achievement badges
  superHost(badge: BadgeData(name: 'Super Host')),
  eventExplorer(badge: BadgeData(name: 'Event Explorer')),
  earlyBird(badge: BadgeData(name: 'Early Bird')),

  // Hotel specific badges
  lyfExperience(badge: BadgeData(name: 'LYF Experience')),
  kuehKuehMaster(badge: BadgeData(name: 'Kueh Kueh Master')),

  // Location-based badges
  commonSpaceRegular(badge: BadgeData(name: 'Common Space Regular')),
  meetingMaestro(badge: BadgeData(name: 'Meeting Maestro')),

  // Specialty interest badges
  aiInnovator(badge: BadgeData(name: 'AI Innovator')),
  waterSportsWizard(badge: BadgeData(name: 'Water Sports Wizard')),
  entertainmentEnthusiast(badge: BadgeData(name: 'Entertainment Enthusiast')),
  ecoWarrior(badge: BadgeData(name: 'Eco Warrior'));

  final BadgeData _badge;

  BadgeData get badge {
    return BadgeData(name: _badge.name);
  }

  BadgeData getBadge(int level) {
    return BadgeData(name: _badge.name, level: level);
  }

  const BadgeEnum({required BadgeData badge}) : _badge = badge;

  static List<BadgeEnum> getBadgesForCategory(EventCategory category) {
    switch (category) {
      case EventCategory.health:
        return [BadgeEnum.yogaLover, BadgeEnum.wellnessWarrior];
      case EventCategory.food:
        return [BadgeEnum.foodie, BadgeEnum.kuehKuehMaster];
      case EventCategory.technology:
      case EventCategory.artificialIntelligence:
        return [BadgeEnum.techEnthusiast, BadgeEnum.aiInnovator];
      case EventCategory.sports:
        return [BadgeEnum.sportsChampion];
      case EventCategory.art:
        return [BadgeEnum.artExplorer];
      case EventCategory.pool:
        return [BadgeEnum.poolPartyPro, BadgeEnum.waterSportsWizard];
      case EventCategory.wellness:
        return [BadgeEnum.wellnessWarrior];
      case EventCategory.sustainability:
      case EventCategory.environment:
        return [BadgeEnum.sustainabilityHero, BadgeEnum.ecoWarrior];
      case EventCategory.networking:
      case EventCategory.business:
        return [BadgeEnum.networkingNinja, BadgeEnum.meetingMaestro];
      case EventCategory.entertainment:
        return [BadgeEnum.entertainmentEnthusiast];
      default:
        return [BadgeEnum.eventExplorer];
    }
  }
}

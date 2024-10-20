import 'package:frontend/models/event.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/lyf_hotels.dart';
import 'package:frontend/models/user.dart';

import '../models/event_categories.dart';

class MockEvents {
  static final MockEvents _instance = MockEvents._internal();

  factory MockEvents() => _instance;

  MockEvents._internal();

  List<Event> events = [
    Event(
      title: 'Yoga event',
      date: DateTime(2021, 10, 22),
      imageUrl: 'images/events/yoga.jpg',
      backgroundColor: '#4caf50',
      localization: 'Commonspace',
      hotel: LyfHotels.Funan,
      description:
          'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
      organizer: User(
        firstName: 'Paul',
        lastName: 'Done',
        age: 30, // Set age for organizer
        userBadges: [EventBadge(name: 'Example Badge')], 
        preferences: {EventCategory.artificialIntelligence}// Empty list of badges
      ),
      registeredUsers: [],
      category: EventCategory.health,
      badges: [EventBadge(name: 'Yoga lover')],
    ),
    Event(
      title: 'Community Cooking Class',
      date: DateTime(2021, 10, 24),
      imageUrl: 'images/events/cooking.jpeg',
      backgroundColor: '#42a5f5',
      localization: 'kitchen',
      hotel: LyfHotels.Funan,
      description:
          'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
      organizer: User(
        firstName: 'Michael',
        lastName: 'Brown',
        age: 28, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      category: EventCategory.food,
      registeredUsers: [],
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),
    Event(
      title: 'Movie Night Under the Stars',
      date: DateTime(2021, 10, 25),
      imageUrl: 'assets/movie_night.jpg',
      backgroundColor: '#7e57c2',
      localization: 'rooftop',
      hotel: LyfHotels.Funan,
      description:
          'Enjoy a cozy movie night under the stars with popcorn and blankets. Bring your friends or meet new ones!',
      organizer: User(
        firstName: 'Sophia',
        lastName: 'Davis',
        age: 26, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      category: EventCategory.networking,
      badges: [EventBadge(name: 'Movie Buff')],
    ),
    Event(
      title: 'Art & Craft Workshop',
      date: DateTime(2021, 10, 26),
      imageUrl: 'assets/art_craft.jpg',
      backgroundColor: '#ef5350',
      localization: 'craft room',
      hotel: LyfHotels.Funan,
      description:
          'Unleash your creativity in our art and craft workshop! All materials provided, just bring your enthusiasm!',
      organizer: User(
        firstName: 'James',
        lastName: 'Wilson',
        age: 32, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      category: EventCategory.art,
      badges: [EventBadge(name: 'Crafty Creator')],
    ),
    Event(
      title: 'Social Run at the Park',
      date: DateTime(2021, 10, 27),
      imageUrl: 'assets/social_run.jpg',
      backgroundColor: '#26c6da',
      localization: 'Nearby park',
      hotel: LyfHotels.Funan,
      description:
          'Join us for a fun social run! All fitness levels are welcome. Let’s enjoy the fresh air and make new friends!',
      organizer: User(
        firstName: 'Olivia',
        lastName: 'Martinez',
        age: 27, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      category: EventCategory.sports,
      badges: [EventBadge(name: 'Running Enthusiast')],
    ),
  ];

  List<Event> myEvents = [
    Event(
      title: 'Yoga event',
      date: DateTime(2021, 10, 22),
      imageUrl: 'images/events/yoga.jpg',
      backgroundColor: '#4caf50',
      localization: 'commonspace',
      hotel: LyfHotels.Funan,
      description:
          'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
      organizer: User(
        firstName: 'Paul',
        lastName: 'Done',
        age: 30, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      category: EventCategory.health,
      badges: [EventBadge(name: 'Yoga lover')],
    ),
    Event(
      title: 'Community Cooking Class',
      date: DateTime(2021, 10, 24),
      imageUrl: 'images/events/cooking.jpeg',
      backgroundColor: '#42a5f5',
      localization: 'kitchen',
      description:
          'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
      organizer: User(
        firstName: 'Michael',
        lastName: 'Brown',
        age: 28, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      hotel: LyfHotels.Funan,
      category: EventCategory.food,
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),
    Event(
      title: 'Community Cooking Class',
      date: DateTime(2021, 10, 24),
      imageUrl: 'images/events/cooking.jpeg',
      backgroundColor: '#42a5f5',
      localization: 'kitchen',
      description:
          'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
      organizer: User(
        firstName: 'Michael',
        lastName: 'Brown',
        age: 28, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      hotel: LyfHotels.Funan,
      category: EventCategory.food,
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),
    Event(
      title: 'Community Cooking Class',
      date: DateTime(2021, 10, 24),
      imageUrl: 'images/events/cooking.jpeg',
      backgroundColor: '#42a5f5',
      localization: 'kitchen',
      description:
          'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
      organizer: User(
        firstName: 'Michael',
        lastName: 'Brown',
        age: 28, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      registeredUsers: [],
      hotel: LyfHotels.Funan,
      category: EventCategory.food,
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),
  ];

  List<Event> hotelEvents = [
    Event(
      title: 'Exclusive Wine Tasting',
      date: DateTime(2021, 11, 10),
      imageUrl: 'assets/wine_tasting.jpg',
      backgroundColor: '#d32f2f',
      localization: 'Wine Lounge',
      hotel: LyfHotels.Funan,
      description:
          'Join us for an exclusive wine tasting event hosted by Lyf Funan. Sample a curated selection of wines from around the world.',
      organizer: User(
        firstName: 'Hotel',
        lastName: 'Staff',
        age: 35, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      isHotelOrganized: true,
      registeredUsers: [],
      category: EventCategory.alcohol,
      badges: [EventBadge(name: 'Wine Connoisseur')],
    ),
    Event(
      title: 'Hotel Mixer: Meet & Greet',
      date: DateTime(2021, 11, 15),
      imageUrl: 'assets/hotel_mixer.jpg',
      backgroundColor: '#5d4037',
      localization: 'Lobby',
      hotel: LyfHotels.Funan,
      description:
          'Come mingle with other hotel guests and meet the friendly hotel staff. Drinks and snacks are on us!',
      organizer: User(
        firstName: 'Hotel',
        lastName: 'Staff',
        age: 35, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      isHotelOrganized: true,
      registeredUsers: [],
      category: EventCategory.networking,
      badges: [EventBadge(name: 'Social Butterfly')],
    ),
    Event(
      title: 'Poolside BBQ Party',
      date: DateTime(2021, 11, 20),
      imageUrl: 'assets/pool_bbq.jpg',
      backgroundColor: '#f57c00',
      localization: 'Poolside',
      hotel: LyfHotels.Funan,
      description:
          'Enjoy a BBQ by the pool, hosted by Lyf Funan. Come for the food, stay for the vibes!',
      organizer: User(
        firstName: 'Hotel',
        lastName: 'Staff',
        age: 35, // Set age for organizer
        userBadges: [], // Empty list of badges
      ),
      isHotelOrganized: true,
      registeredUsers: [],
      category: EventCategory.food,
      badges: [EventBadge(name: 'BBQ Lover')],
    ),
  ];

  List<Event> getEvents() {
    return events;
  }

  List<Event> getMyEvents(User currentUser) {
    return events.where((event) => event.registeredUsers.contains(currentUser)).toList();
  }

  List<Event> getHotelEvents() {
    return hotelEvents;
  }
}

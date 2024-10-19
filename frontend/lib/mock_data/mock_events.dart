import 'package:frontend/models/EventBadge.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/lyf_hotels.dart';
import 'package:frontend/models/user.dart';

class MockEvents {
  static final MockEvents _instance = MockEvents._internal();

  factory MockEvents() => _instance;

  MockEvents._internal();

  User currentUser = User(firstName: 'Lukasz', lastName: 'Kryczka');

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
        ),
        registeredUsers: [],
        badges: [EventBadge(name: 'Yoga lover')]),
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
        ),
        registeredUsers: [],
        badges: [EventBadge(name: 'Cooking Enthusiast')]),
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
        ),
        registeredUsers: [],
        badges: [EventBadge(name: 'Movie Buff')]),
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
        ),
        registeredUsers: [],
        badges: [EventBadge(name: 'Crafty Creator')]),
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
        ),
        registeredUsers: [],
        badges: [EventBadge(name: 'Running Enthusiast')]),
  ];

  List<Event> myEvents = [
    Event(
        title: 'Yoga event',
        date: DateTime(2021, 10, 22),
        imageUrl: 'images/events/yoga.jpg',
        backgroundColor: '#4caf50',
        localization: 'Lyf Funan, commonspace',
        hotel: LyfHotels.Funan,
        description:
            'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
        organizer: User(
          firstName: 'Paul',
          lastName: 'Done',
        ),
        registeredUsers: [],
        badges: [EventBadge(name: 'Yoga lover')]),
  ];

  List<Event> hotelEvents = [
    Event(
        title: 'Exclusive Wine Tasting',
        date: DateTime(2021, 11, 10),
        imageUrl: 'assets/wine_tasting.jpg',
        backgroundColor: '#d32f2f',
        localization: 'Lyf Funan Wine Lounge',
        hotel: LyfHotels.Funan,
        description:
            'Join us for an exclusive wine tasting event hosted by Lyf Funan. Sample a curated selection of wines from around the world.',
        organizer: User(
          firstName: 'Hotel',
          lastName: 'Staff',
        ),
        isHotelOrganized: true,
        registeredUsers: [],
        badges: [EventBadge(name: 'Wine Connoisseur')]),
    Event(
        title: 'Hotel Mixer: Meet & Greet',
        date: DateTime(2021, 11, 15),
        imageUrl: 'assets/hotel_mixer.jpg',
        backgroundColor: '#5d4037',
        localization: 'Lyf Funan Lobby',
        hotel: LyfHotels.Funan,
        description:
            'Come mingle with other hotel guests and meet the friendly hotel staff. Drinks and snacks are on us!',
        organizer: User(
          firstName: 'Hotel',
          lastName: 'Staff',
        ),
        isHotelOrganized: true,
        registeredUsers: [],
        badges: [EventBadge(name: 'Social Butterfly')]),
    Event(
        title: 'Poolside BBQ Party',
        date: DateTime(2021, 11, 20),
        imageUrl: 'assets/pool_bbq.jpg',
        backgroundColor: '#f57c00',
        localization: 'Lyf Funan Poolside',
        hotel: LyfHotels.Funan,
        description:
            'Enjoy a BBQ by the pool, hosted by Lyf Funan. Come for the food, stay for the vibes!',
        organizer: User(
          firstName: 'Hotel',
          lastName: 'Staff',
        ),
        isHotelOrganized: true,
        registeredUsers: [],
        badges: [EventBadge(name: 'BBQ Lover')]),
  ];

  List<Event> getEvents() {
    return events;
  }

  List<Event> getMyEvents() {
    return myEvents;
  }

  List<Event> getHotelEvents() {
    return hotelEvents;
  }
}

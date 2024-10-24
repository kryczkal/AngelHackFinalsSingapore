import 'package:flutter/material.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/lyf_hotels_enum.dart';
import 'package:frontend/models/user_data.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/app_data/app_user.dart';

import '../models/event_categories_enum.dart';

class AppEventsSingleton extends ChangeNotifier {
  static final AppEventsSingleton _instance = AppEventsSingleton._internal();

  factory AppEventsSingleton() => _instance;

  AppEventsSingleton._internal();

  List<Event> events = [
    Event(
      title: 'Business ABC Collab',
      date: DateTime(2024, 11, 22),
      imageUrl: 'images/events/private/lyf-funan-meeting-room-collab.png',
      backgroundColor: '#4caf50',
      localization: 'COLLAB',
      hotel: LyfHotels.Funan,
      description:
          'This event is exclusive to members of company ABC. Join us for an important meeting at Lyf Funan Singapore Hotel to discuss the upcoming fusion of our companies. This event will outline key strategies and opportunities for collaboration as we move forward together.',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Piotr", "Tyrakowski"),
      registeredUsers: [],
      category: EventCategory.business,
      badges: [],
      isPrivate: true,
      password: '1234',
    ),
    Event(
      title: 'Yoga event',
      date: DateTime(2021, 10, 22),
      imageUrl: 'images/events/people/yoga.jpg',
      backgroundColor: '#4caf50',
      localization: 'Commonspace',
      hotel: LyfHotels.Funan,
      description:
          'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
      organizer: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Paul' && user.lastName == 'Done'),
      //isHotelOrganized: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Paul' && user.lastName == 'Done').isManager,
      registeredUsers: [],
      category: EventCategory.health,
      badges: [EventBadge(name: 'Yoga lover')],
    ),

    Event(
      title: 'Community Cooking Class',
      date: DateTime(2021, 10, 24),
      imageUrl: 'images/events/people/cooking.jpeg',
      backgroundColor: '#42a5f5',
      localization: 'kitchen',
      hotel: LyfHotels.Funan,
      description:
          'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
      organizer: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Michael' && user.lastName == 'Brown'),
      //isHotelOrganized: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Michael' && user.lastName == 'Brown').isManager,
      registeredUsers: [],
      category: EventCategory.food,
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),

    Event(
      title: 'Movie Night Under the Stars',
      date: DateTime(2021, 10, 25),
      imageUrl: 'images/events/yoga.jpg',
      backgroundColor: '#7e57c2',
      localization: 'rooftop',
      hotel: LyfHotels.Funan,
      description:
          'Enjoy a cozy movie night under the stars with popcorn and blankets. Bring your friends or meet new ones!',
      organizer: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Sophia' && user.lastName == 'Davis'),
      //isHotelOrganized: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Sophia' && user.lastName == 'Davis').isManager,
      registeredUsers: [],
      category: EventCategory.networking,
      badges: [EventBadge(name: 'Movie Buff')],
    ),

   Event(
      title: 'Art & Craft Workshop',
      date: DateTime(2021, 10, 26),
      imageUrl: 'images/events/yoga.jpg',
      backgroundColor: '#ef5350',
      localization: 'craft room',
      hotel: LyfHotels.Funan,
      description:
          'Unleash your creativity in our art and craft workshop! All materials provided, just bring your enthusiasm!',
      organizer: AppUserSingleton().users.firstWhere((user) => user.firstName == 'James' && user.lastName == 'Wilson'),
      //isHotelOrganized: AppUserSingleton().users.firstWhere((user) => user.firstName == 'James' && user.lastName == 'Wilson').isManager,
      registeredUsers: [],
      category: EventCategory.art,
      badges: [EventBadge(name: 'Crafty Creator')],
    ),

    Event(
      title: 'Social Run at the Park',
      date: DateTime(2021, 10, 27),
      imageUrl: 'images/events/yoga.jpg',
      backgroundColor: '#26c6da',
      localization: 'Nearby park',
      hotel: LyfHotels.Funan,
      description:
          'Join us for a fun social run! All fitness levels are welcome. Let’s enjoy the fresh air and make new friends!',
      organizer: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Olivia' && user.lastName == 'Martinez'),
      //isHotelOrganized: AppUserSingleton().users.firstWhere((user) => user.firstName == 'Olivia' && user.lastName == 'Martinez').isManager,
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
        age: 30,
        userBadges: [],
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
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
        age: 28,
        userBadges: [],
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
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
        age: 28,
        userBadges: [],
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
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
        age: 28,
        userBadges: [],
        location: 'Singapore',
        profilePic: 'images/profile/profile.jpg',
      ),
      registeredUsers: [],
      hotel: LyfHotels.Funan,
      category: EventCategory.food,
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),
  ];


  // List<Event> hotelEvents = [
  //   Event(
  //     title: 'Exclusive Wine Tasting',
  //     date: DateTime(2021, 11, 10),
  //     imageUrl: 'images/events/cooking.jpeg',
  //     backgroundColor: '#d32f2f',
  //     localization: 'Wine Lounge',
  //     hotel: LyfHotels.Funan,
  //     description:
  //         'Join us for an exclusive wine tasting event hosted by Lyf Funan. Sample a curated selection of wines from around the world.',
  //     organizer: User(
  //       firstName: 'Hotel',
  //       lastName: 'Staff',
  //       age: 35,
  //       userBadges: [],
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     isHotelOrganized: true,
  //     registeredUsers: [],
  //     category: EventCategory.alcohol,
  //     badges: [EventBadge(name: 'Wine Connoisseur')],
  //   ),
  //   Event(
  //     title: 'Hotel Mixer: Meet & Greet',
  //     date: DateTime(2021, 11, 15),
  //     imageUrl: 'images/events/cooking.jpeg',
  //     backgroundColor: '#5d4037',
  //     localization: 'Lobby',
  //     hotel: LyfHotels.Funan,
  //     description:
  //         'Come mingle with other hotel guests and meet the friendly hotel staff. Drinks and snacks are on us!',
  //     organizer: User(
  //       firstName: 'Hotel',
  //       lastName: 'Staff',
  //       age: 35, // Set age for organizer
  //       userBadges: [], // Empty list of badges
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     isHotelOrganized: true,
  //     registeredUsers: [],
  //     category: EventCategory.networking,
  //     badges: [EventBadge(name: 'Social Butterfly')],
  //   ),
  //   Event(
  //     title: 'Poolside BBQ Party',
  //     date: DateTime(2021, 11, 20),
  //     imageUrl: 'images/events/cooking.jpeg',
  //     backgroundColor: '#f57c00',
  //     localization: 'Poolside',
  //     hotel: LyfHotels.Funan,
  //     description:
  //         'Enjoy a BBQ by the pool, hosted by Lyf Funan. Come for the food, stay for the vibes!',
  //     organizer: User(
  //       firstName: 'Hotel',
  //       lastName: 'Staff',
  //       age: 35, // Set age for organizer
  //       userBadges: [], // Empty list of badges
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     isHotelOrganized: true,
  //     registeredUsers: [],
  //     category: EventCategory.food,
  //     badges: [EventBadge(name: 'BBQ Lover')],
  //   ),
  // ];

  List<Event> getEvents() {
    return events;
  }

  List<Event> getMyRegisteredEvents(User currentUser) {
    return currentUser.registeredEvents;
  }

  List<Event> getMyCreatedEvents(User currentUser) {
    return currentUser.createdEvents;
  }


  List<Event> getAllPublicEvents() {
    return events.where((event) => !event.isPrivate).toList();
  }

  List<Event> getPublicPeopleEvents() {
    return events.where((event) => !event.isPrivate).toList();
  }

  List<Event> getHotelEvents() {
    return events.where((event) => event.isHotelOrganized).toList();
  }

  List<Event> getPrivatePeopleEvents(User user) {
    return events.where((event) => event.isPrivate && event.organizer != user).toList();
  }

  void addEvent(Event event) {
    events.add(event);
    notifyListeners();
  }

  void toggleUserRegistration(Event event, User user) {
    if (event.registeredUsers.contains(user)) {
      user.registeredEvents.remove(event);
      event.registeredUsers.remove(user);
    } else {
      event.registeredUsers.add(user);
      user.registeredEvents.add(event);
    }
    notifyListeners();
  }
}

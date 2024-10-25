import 'package:flutter/material.dart';
import 'package:frontend/models/event_badge.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/lyf_hotels_enum.dart';
import 'package:frontend/models/user_data.dart';
import 'package:frontend/models/event_categories_enum.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:collection/collection.dart'; // Add this import


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

    // hotel event
    Event(
      title: 'Yoga event',
      date: DateTime(2021, 10, 22, 10, 00),
      imageUrl: 'images/events/people/lyf_yoga.jpg',
      backgroundColor: '#4caf50',
      localization: 'Commonspace',
      hotel: LyfHotels.Sukhumvit,
      description:
          'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Paul", "Done"),
      registeredUsers: [],
      category: EventCategory.health,
      badges: [EventBadge(name: 'Yoga lover')],
    ),

    // Hotel event
    Event(
      title: 'Community Cooking Class',
      date: DateTime(2021, 10, 24),
      imageUrl: 'images/events/hotel/lyf_cooking.jpg',
      backgroundColor: '#42a5f5',
      localization: 'The Bond Kitchen',
      hotel: LyfHotels.Funan,
      description:
          'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Michael", "Brown"),
      registeredUsers: [],
      category: EventCategory.food,
      badges: [EventBadge(name: 'Cooking Enthusiast')],
    ),

    // Hotel event
    Event(
      title: 'Movie Night: Formula 1: Drive to Survive',
      date: DateTime(2024, 10, 25),
      imageUrl: 'images/events/hotel/lyf_movie_night.jpg',
      backgroundColor: '#7e57c2',
      localization: 'movie center',
      hotel: LyfHotels.Funan,
      description:
          'Enjoy the latest episode of Formula 1: Drive to Survive. Bring your friends or meet new ones!',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Michael", "Brown"),
      registeredUsers: [],
      category: EventCategory.entertainment,
      badges: [EventBadge(name: 'Movie Buff')],
    ),

   Event(
      title: 'Singapore Art Museum',
      date: DateTime(2021, 10, 26),
      imageUrl: 'images/events/people/singapore_art_museum.jpeg',
      backgroundColor: '#ef5350',
      localization: 'Singapore Art Museum',
      hotel: LyfHotels.Funan,
      description:
          "Visit the Singapore Art Museum and learn about the history of art in Singapore.",
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("James", "Wilson"),
      registeredUsers: [],
      category: EventCategory.art,
      badges: [EventBadge(name: 'Art Enthusiast')],
    ),

    // people event
    Event(
      title: 'Social Run at the Park',
      date: DateTime(2021, 10, 27),
      imageUrl: 'images/events/people/funan_park.jpg',
      backgroundColor: '#26c6da',
      localization: 'Nearby park',
      hotel: LyfHotels.Funan,
      description:
          'Join us for a fun social run! All fitness levels are welcome. Let’s enjoy the fresh air and make new friends!',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Olivia", "Martinez"),
      registeredUsers: [],
      category: EventCategory.sports,
      badges: [EventBadge(name: 'Running Enthusiast')],
    ),

    // people event
    Event(
      title: 'Rope Climbing',
      date: DateTime(2021, 10, 28),
      imageUrl: 'images/events/people/lyf_climbing.jpg',
      backgroundColor: '#66bb6a',
      localization: 'rope climbing center',
      hotel: LyfHotels.Funan,
      description:
          'Join us for a fun rope climbing event! All fitness levels are welcome. Let’s enjoy the fresh air and make new friends!',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Olivia", "Martinez"),
      registeredUsers: [],
      category: EventCategory.sports,
      badges: [EventBadge(name: 'Rope Climbing Enthusiast')],
    ),
    // people event
    Event(
      title: 'Pool Party',
      date: DateTime(2021, 10, 29),
      imageUrl: 'images/events/people/lyf_pool.jpg',
      backgroundColor: '#f57c00',
      localization: 'Pool area',
      hotel: LyfHotels.Funan,
      description:
          "Enjoy a pool party at the nearby pool. Bring your friends or meet new ones!",
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("James", "Wilson"),
      registeredUsers: [],
      category: EventCategory.food,
      badges: [EventBadge(name: 'Pool Party Lover')],
    ),


    // MAIN EVENT
    Event(
      title: 'Kueh Kueh Lyf',
      date: DateTime(2024, 11, 16, 11, 00),
      imageUrl: 'images/events/hotel/lyf_kueh_kueh.png',
      backgroundColor: '#4caf50',
      localization: 'lyf Farrer Park Singapore',
      hotel: LyfHotels.Funan,
      description:
          'In this workshop, you will be guided on how to bead & embroider on a frame, with an average of 100-300 beads. Choose your own design or draw your own patterns of your choice and learn how to beads embroider the Peranakan way! This workshop is thoughtfully designed to accommodate diverse skill levels, welcoming both beginners and non-beginners. With expert guidance from our master artisan and all the necessary materials, you can fully focus on your creative journey and witness your creation come to life!',
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Hotel", "Staff"),
      registeredUsers: [],
      category: EventCategory.food,
      badges: [EventBadge(name: 'Food Lover')],
    ),

    Event(
      title: 'A Walk with lyf - Bubble Planet',
      date: DateTime(2024, 11, 22, 14, 45),
      imageUrl: 'images/events/hotel/lyf_bubble_planet.png',
      backgroundColor: '#4caf50',
      localization: 'Hall 8B Singapore Expo, 9 Somapah Road',
      hotel: LyfHotels.Funan,
      description:
          "[RESIDENT EXCLUSIVE] It's safe to say that there isn’t a kid (or adult) who doesn’t love bubbles! Well, step into a literal dream come true at Bubble Planet: An Immersive Experience. Making its Asia-Pacific and Singapore Debut from Milan, this surreal interactive experience will bring you through a whimsical world of bubbles that spans 11 themed areas. ",
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Hotel", "Staff"),
      registeredUsers: [],
      category: EventCategory.entertainment,
      badges: [EventBadge(name: 'Bubble Lover')],
    ),

    Event(
      title: 'lyf Sustainival',
      date: DateTime(2024, 10, 26, 11, 00),
      imageUrl: 'images/events/hotel/lyf_sustainival.png',
      backgroundColor: '#4caf50',
      localization: 'lyf Hotel',
      hotel: LyfHotels.Funan,
      description:
          "Join us for a day of fun and sustainability at lyf Hotel! We'll be hosting a variety of activities and workshops to help you learn about and participate in sustainable living. From recycling and composting to planting and upcycling, there's something for everyone to enjoy and contribute to our planet. Plus, we'll have live music, food trucks, and more to keep you entertained all day long. Don't miss out on this opportunity to make a positive impact while having fun!",
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Hotel", "Staff"),
      registeredUsers: [],
      category: EventCategory.sustainability,
      badges: [EventBadge(name: 'Sustainival Lover')],
    ),

    Event(
      title: 'lyf Funan Singapore Halloween 2024',
      date: DateTime(2024, 10, 28, 10, 00),
      imageUrl: 'images/events/hotel/lyf_halloween.png',
      backgroundColor: '#4caf50',
      localization: 'lyf Hotel',
      hotel: LyfHotels.Funan,
      description:
          "[RESIDENT EXCLUSIVE] join us for a spooky halloween 2024! Make your own witches potions art & craft and enjoy a spooky movie night!",
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Hotel", "Staff"),
      registeredUsers: [],
      category: EventCategory.entertainment,
      badges: [EventBadge(name: 'Halloween Enthusiast')],
    ),

    Event(
      title: 'lyf x This.Connect - Pay it Forward Movement',
      date: DateTime(2024, 11, 15, 14, 00),
      imageUrl: 'images/events/hotel/lyf_pay_it_forward.png',
      backgroundColor: '#4caf50',
      localization: 'lyf Hotel',
      hotel: LyfHotels.Funan,
      description:
          "[RESIDENT EXCLUSIVE] Write well wishes on a postcard and pass it forward to someone or a random stranger! Let's spread kindness and positivity together!",
      organizer: AppUserSingleton().getUserByFirstNameAndLastName("Hotel", "Staff"),
      registeredUsers: [],
      category: EventCategory.wellness,
      badges: [EventBadge(name: 'Pay it Forward Enthusiast')],
    ),
  ];

  
  // List<Event> myEvents = [
  //   Event(
  //     title: 'Yoga event',
  //     date: DateTime(2021, 10, 22),
  //     imageUrl: 'images/events/yoga.jpg',
  //     backgroundColor: '#4caf50',
  //     localization: 'commonspace',
  //     hotel: LyfHotels.Funan,
  //     description:
  //         'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
  //     organizer: User(
  //       firstName: 'Paul',
  //       lastName: 'Done',
  //       age: 30,
  //       userBadges: [],
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     registeredUsers: [],
  //     category: EventCategory.health,
  //     badges: [EventBadge(name: 'Yoga lover')],
  //   ),
  //   Event(
  //     title: 'Community Cooking Class',
  //     date: DateTime(2021, 10, 24),
  //     imageUrl: 'images/events/cooking.jpeg',
  //     backgroundColor: '#42a5f5',
  //     localization: 'kitchen',
  //     description:
  //         'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
  //     organizer: User(
  //       firstName: 'Michael',
  //       lastName: 'Brown',
  //       age: 28,
  //       userBadges: [],
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     registeredUsers: [],
  //     hotel: LyfHotels.Funan,
  //     category: EventCategory.food,
  //     badges: [EventBadge(name: 'Cooking Enthusiast')],
  //   ),
  //   Event(
  //     title: 'Community Cooking Class',
  //     date: DateTime(2021, 10, 24),
  //     imageUrl: 'images/events/cooking.jpeg',
  //     backgroundColor: '#42a5f5',
  //     localization: 'kitchen',
  //     description:
  //         'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
  //     organizer: User(
  //       firstName: 'Michael',
  //       lastName: 'Brown',
  //       age: 28,
  //       userBadges: [],
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     registeredUsers: [],
  //     hotel: LyfHotels.Funan,
  //     category: EventCategory.food,
  //     badges: [EventBadge(name: 'Cooking Enthusiast')],
  //   ),
  //   Event(
  //     title: 'Community Cooking Class',
  //     date: DateTime(2021, 10, 24),
  //     imageUrl: 'images/events/cooking.jpeg',
  //     backgroundColor: '#42a5f5',
  //     localization: 'kitchen',
  //     description:
  //         'Come learn new recipes and cooking techniques in our community cooking class! Share a meal and make new friends!',
  //     organizer: User(
  //       firstName: 'Michael',
  //       lastName: 'Brown',
  //       age: 28,
  //       userBadges: [],
  //       location: 'Singapore',
  //       profilePic: 'images/profile/profile.jpg',
  //     ),
  //     registeredUsers: [],
  //     hotel: LyfHotels.Funan,
  //     category: EventCategory.food,
  //     badges: [EventBadge(name: 'Cooking Enthusiast')],
  //   ),
  // ];


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
    return events.where((event) => !event.isPrivate && !event.isHotelOrganized).toList();
  }

  List<Event> getHotelEvents() {
    return events.where((event) => event.isHotelOrganized && !event.isPrivate).toList();
  }


  Event? getPrivatePeopleEvent(String code) {
    return events.firstWhereOrNull(
      (event) => event.isPrivate && event.password == code
    );
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

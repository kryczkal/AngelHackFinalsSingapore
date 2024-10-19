import 'package:frontend/models/event.dart';

// Singleton class to hold mock events data
class MockEvents {
  static final MockEvents _instance = MockEvents._internal();
  factory MockEvents() => _instance;
  MockEvents._internal();

  List<Event> events = [
    Event(
      title: 'Poolside Barbecue',
      date: 'October 21',
      imageUrl: 'assets/poolside_bbq.jpg',
      backgroundColor: '#ff6f61',
    ),
    Event(
      title: 'Game Night: Bowling Tournament',
      date: 'October 22',
      imageUrl: 'assets/bowling.jpg',
      backgroundColor: '#4caf50',
    ),
    Event(
      title: 'Yoga & Wellness Morning',
      date: 'October 23',
      imageUrl: 'assets/yoga.jpg',
      backgroundColor: '#ffa726',
    ),
    Event(
      title: 'Community Cooking Class',
      date: 'October 24',
      imageUrl: 'assets/cooking_class.jpg',
      backgroundColor: '#42a5f5',
    ),
    Event(
      title: 'Movie Night Under the Stars',
      date: 'October 25',
      imageUrl: 'assets/movie_night.jpg',
      backgroundColor: '#7e57c2',
    ),
    Event(
      title: 'Art & Craft Workshop',
      date: 'October 26',
      imageUrl: 'assets/art_craft.jpg',
      backgroundColor: '#ef5350',
    ),
    Event(
      title: 'Social Run at the Park',
      date: 'October 27',
      imageUrl: 'assets/social_run.jpg',
      backgroundColor: '#26c6da',
    ),
  ];

  List<Event> myEvents = [
    Event(
      title: 'Basketball conference',
      date: 'April 29',
      imageUrl: 'assets/basketball.jpg',
      backgroundColor: '#007aff',
    ),
  ];

  List<Event> getEvents() {
    return events;
  }

  List<Event> getMyEvents() {
    return myEvents;
  }
}

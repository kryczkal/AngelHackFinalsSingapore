import 'package:flutter/material.dart';
import 'package:frontend/models/EventBadge.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/user.dart';

User lukasz = User(
  firstName: 'Lukasz',
  lastName: 'Kryczka',
);

EventBadge yogaLover = EventBadge(name: 'Yoga lover');

Event yogaEvent = Event(
    title: 'Yoga event',
    date: '20.10.2024 12:00 pm',
    imageUrl:
        'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    backgroundColor: Colors.red.toString(),
    localization: 'Lyf Funan, commonspace',
    description: 'Hey everyone! Looking for a fun way to unwind and meet new friends? Join me at Lyf Funan Singapore Hotel for a refreshing yoga class! Whether you’re a seasoned yogi or just starting out, all levels are welcome!',
    organizer: lukasz,
    registeredUsers: [],
    badges: [yogaLover]);

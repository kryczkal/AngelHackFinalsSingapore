import 'package:frontend/models/event_data.dart';

class Review {
  final int rating;
  final String? comments;
  final Event event;

  Review({
    required this.rating,
    this.comments,
    required this.event,
  });
}

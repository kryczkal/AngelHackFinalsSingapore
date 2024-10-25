import 'package:flutter/material.dart';

enum EventLocationEnum {
  yogaRoom,
  gym,
  conferenceRoomA,
  conferenceRoomB,
  mainHall,
  trainingRoom,
  outdoorArea,
}

extension EventLocationEnumExtension on EventLocationEnum {
  String toDisplayString() {
    final String enumString = toString().split('.').last;

    final List<String> words = enumString
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    return words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  static List<String> toDisplayList() {
    return EventLocationEnum.values.map((e) => e.toDisplayString()).toList();
  }
}

extension EventLocationIconExtension on EventLocationEnum {
  IconData get icon {
    switch (this) {
      case EventLocationEnum.yogaRoom:
        return Icons.self_improvement;
      case EventLocationEnum.gym:
        return Icons.fitness_center;
      case EventLocationEnum.conferenceRoomA:
      case EventLocationEnum.conferenceRoomB:
        return Icons.meeting_room;
      case EventLocationEnum.mainHall:
        return Icons.domain;
      case EventLocationEnum.trainingRoom:
        return Icons.school;
      case EventLocationEnum.outdoorArea:
        return Icons.park;
    }
  }

  Widget toIconAndText({
    double? iconSize,
    Color? iconColor,
    TextStyle? textStyle,
    double spacing = 8.0,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(width: spacing),
        Text(
          toDisplayString(),
          style: textStyle,
        ),
      ],
    );
  }
}

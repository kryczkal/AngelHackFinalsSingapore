import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/pages/events/event_details_page.dart';
import 'package:intl/intl.dart';

enum EventCardType { maxInfo, lessInfo, minInfo }

class EventCard extends StatefulWidget {
  final Event event;
  final EventCardType type;
  final bool rightPadding;

  const EventCard({
    super.key,
    required this.event,
    this.type = EventCardType.maxInfo,
    this.rightPadding = true,
  });

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCard> with TickerProviderStateMixin {
  Widget _getRoundedText(BuildContext context, String text) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(eventDetails: widget.event),
          ),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double horizontalPadding =
              constraints.maxWidth < 200 ? 8.0 : 16.0;
          final double verticalPadding =
              constraints.maxHeight < 150 ? 8.0 : 16.0;

          return Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Color(int.parse(
                  widget.event.backgroundColor.replaceFirst('#', '0xff'))),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(widget.event.imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: verticalPadding,
                    left: horizontalPadding,
                    right: horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.type == EventCardType.maxInfo) ...[
                        Icon(
                          widget.event.isHotelOrganized
                              ? FontAwesomeIcons.hotel
                              : Icons.person,
                          color: Colors.white,
                          size: constraints.maxWidth < 200 ? 16 : 24,
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        widget.event.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: constraints.maxWidth < 200 ? 14 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: verticalPadding,
                    left: horizontalPadding,
                    right: horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.type != EventCardType.minInfo) ...[
                        _getRoundedText(
                          context,
                          DateFormat('EEEE, MMM d').format(widget.event.date),
                        ),
                      ],
                      if (widget.type == EventCardType.maxInfo) ...[
                        const SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _getRoundedText(context, widget.event.hotel.name),
                              const SizedBox(width: 8),
                              _getRoundedText(
                                  context, widget.event.localization),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

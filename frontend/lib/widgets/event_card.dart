import 'package:flutter/material.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/pages/event_details_page.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> with TickerProviderStateMixin {
  @override
  Widget _getRoundedText(BuildContext context, String text) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
      ),
    );
  }

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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 8,
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.end,
            children: [
              Icon(
                widget.event.isHotelOrganized
                    ? Icons.hotel // Hotel icon
                    : Icons.person, // Person icon
                color: Colors.white,
                size: 24,
              ),
              Text(
                widget.event.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(-4, 0),
                child: SizedBox(
                  height: 30,
                  child: Wrap(spacing: 8, children: [
                    _getRoundedText(context,
                        DateFormat('EEEE, MMM d').format(widget.event.date)),
                  ]),
                ),
              ),
              Transform.translate(
                offset: const Offset(-4, 0),
                child: SizedBox(
                  height: 30,
                  child: Wrap(spacing: 8, children: [
                    _getRoundedText(context, widget.event.hotel.name),
                    _getRoundedText(context, widget.event.localization),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

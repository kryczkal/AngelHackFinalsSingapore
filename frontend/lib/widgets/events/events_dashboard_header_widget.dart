import 'package:flutter/material.dart';
import 'package:frontend/pages/events/joined_events_page.dart';
import 'package:frontend/widgets/events/joined_events_card.dart';
import 'package:frontend/widgets/events/your_events_card.dart';
import 'package:frontend/widgets/misc/show_case_wrapper_widget.dart';

class EventsDashboardHeader extends StatelessWidget {
  final GlobalKey eventScheduleKey;

  final GlobalKey createdEventsKey;

  final GlobalKey newEventKey;

  const EventsDashboardHeader({
    super.key,
    required this.eventScheduleKey,
    required this.createdEventsKey,
    required this.newEventKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShowcaseWrapper(
          showcaseKey: eventScheduleKey,
          title: "View your event schedule",
          description:
              "Here you can view all the events you have joined."
                  "You can also view the events you have created.",
          child: Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JoinedEventsPage()),
                );
              },
              child: const SizedBox(
                height: 176,
                child: JoinedEventsCard(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        const Expanded(
          child: Column(
            children: [
              SizedBox(height: 46),
              SizedBox(
                height: 176,
                child: YourEventsCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

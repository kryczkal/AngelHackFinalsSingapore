import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/events/event_card.dart';
import 'package:frontend/widgets/events/events_dashboard_header.dart';
import 'package:frontend/widgets/events/events_header.dart';
import 'package:frontend/widgets/misc/app_scroll_behavior_web_extended.dart';
import 'package:frontend/widgets/misc/ignore_padding_widget.dart';
import 'package:frontend/widgets/user/user_profile_header.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(hasNotification: true),
              const SizedBox(height: 12),
              const EventsDashboardHeader(),
              const SizedBox(height: 24),
              const EventsHeader(title: 'Might\ninterest you'),
              const SizedBox(height: 16),
              IgnorePaddingWidget(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: PageView.builder(
                    scrollBehavior: ScrollBehaviorWebExtended(),
                    controller: PageController(viewportFraction: 0.80),
                    itemCount: AppEventsSingleton().events.length,
                    itemBuilder: (context, index) {
                      return _buildEventCard(
                          AppEventsSingleton().events[index]);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const EventsHeader(title: 'Last\nMinute'),
              const SizedBox(height: 16),
              IgnorePaddingWidget(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: PageView.builder(
                    scrollBehavior: ScrollBehaviorWebExtended(),
                    controller: PageController(viewportFraction: 0.80),
                    itemCount: AppEventsSingleton().events.length,
                    itemBuilder: (context, index) {
                      return _buildEventCard(
                          AppEventsSingleton().events[index]);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const EventsHeader(title: 'Best\nglobally'),
              const SizedBox(height: 16),
              IgnorePaddingWidget(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: PageView.builder(
                    scrollBehavior: ScrollBehaviorWebExtended(),
                    controller: PageController(viewportFraction: 0.80),
                    itemCount: AppEventsSingleton().events.length,
                    itemBuilder: (context, index) {
                      return _buildEventCard(
                          AppEventsSingleton().events[index]);
                    },
                  ),
                ),
              ),
              // CustomBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: EventCard(event: event),
      ),
    );
  }
}

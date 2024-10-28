import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/events/event_card.dart';
import 'package:frontend/widgets/events/events_dashboard_header_widget.dart';
import 'package:frontend/widgets/events/events_header.dart';
import 'package:frontend/widgets/events/interesting_events_section.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';
import 'package:frontend/widgets/misc/ignore_padding_widget.dart';
import 'package:frontend/widgets/misc/show_case_wrapper_widget.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';
import 'package:frontend/widgets/user/user_profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  final GlobalKey profileKey = GlobalKey();
  final GlobalKey seeAllKey = GlobalKey();
  final GlobalKey browseEventsKey = GlobalKey();

  final GlobalKey eventScheduleKey = GlobalKey();
  final GlobalKey createdEventsKey = GlobalKey();
  final GlobalKey newEventKey = GlobalKey();

  @override
  void initState() {
    _checkFirstTimeUser();
    super.initState();
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time_user_home') ?? true;

    if (isFirstTime && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([
          profileKey,
          browseEventsKey,
          seeAllKey,
          eventScheduleKey,
          createdEventsKey,
          newEventKey
        ]);

        prefs.setBool('first_time_user_home', false);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollViewWebExtended(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(hasNotification: true, showKey: profileKey),
                const SizedBox(height: 12),

                // Events Dashboard Header
                EventsDashboardHeader(
                  eventScheduleKey: eventScheduleKey,
                  newEventKey: newEventKey,
                  createdEventsKey: createdEventsKey,
                ),
                const SizedBox(height: 24),

                EventsHeader(title: 'Might\ninterest you', showKey: seeAllKey),
                const SizedBox(height: 16),

                ShowcaseWrapper(
                  showcaseKey: browseEventsKey,
                  title: "Browse events suggestions",
                  description: "Browse events grouped by suggestion criteria!",
                  child: IgnorePaddingWidget(
                    child: InterestingEventsSection(
                      events: AppEventsSingleton()
                          .getInterestingEvents(AppUserSingleton().currentUser),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const EventsHeader(title: 'Last\nMinute'),
                const SizedBox(height: 16),

                IgnorePaddingWidget(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: PageView.builder(
                      scrollBehavior: ScrollBehaviorWebExtended(),
                      controller: PageController(viewportFraction: 0.80),
                      itemCount:
                          AppEventsSingleton().getLastMinuteEvents().length,
                      itemBuilder: (context, index) {
                        return _buildEventCard(
                          AppEventsSingleton()
                              .getLastMinuteEvents()
                              .elementAt(index),
                        );
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
                      itemCount: AppEventsSingleton().getBestEvents().length,
                      itemBuilder: (context, index) {
                        return _buildEventCard(
                          AppEventsSingleton().getBestEvents().elementAt(index),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

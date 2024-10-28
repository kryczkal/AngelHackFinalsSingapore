import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_manager.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/lyf_hotels_enum.dart';
import 'package:frontend/models/report_data.dart';
import 'package:frontend/models/report_timeline_enum.dart';
import 'package:frontend/pages/events/event_create_page.dart';
import 'package:frontend/pages/misc/blank_page.dart';
import 'package:frontend/widgets/manager/demography_widget.dart';
import 'package:frontend/widgets/manager/event_suggestion_card.dart';
import 'package:frontend/widgets/manager/dashboard_card_widget.dart';
import 'package:frontend/widgets/manager/manager_header_widget.dart';
import 'package:frontend/widgets/misc/show_case_wrapper_widget.dart';
import 'package:frontend/widgets/misc/single_child_scroll_view_web_extended.dart';
import 'package:frontend/widgets/user/user_profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ManagerDashboardPage extends StatefulWidget {
  const ManagerDashboardPage({super.key});

  @override
  State<ManagerDashboardPage> createState() => _ManagerDashboardPageState();
}

class _ManagerDashboardPageState extends State<ManagerDashboardPage> {
  final GlobalKey timeLineKey = GlobalKey();
  final GlobalKey suggestionKey = GlobalKey();
  final GlobalKey biKey = GlobalKey();
  final GlobalKey addHotelEvent = GlobalKey();

  final Map<ReportTimeline, ReportData> _reportData =
      AppManagerSingleton().reportData;
  ReportTimeline _selectedTimeline = ReportTimeline.week;

  @override
  void initState() {
    _showcaseTest();
    super.initState();
  }

  Future<void> _showcaseTest() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time_mgr') ?? true;

    if (isFirstTime && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context)
            .startShowCase([timeLineKey, suggestionKey, biKey, addHotelEvent]);
      });

      prefs.setBool('first_time_mgr', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollViewWebExtended(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const ProfileHeader(
                        hasNotification: true, showProfile: false),
                    const SizedBox(height: 16),
                    ManagerHeaderWidget(
                      reportData: _reportData,
                      onTimelineChanged: (timeline) {
                        setState(() {
                          _selectedTimeline = timeline;
                        });
                      },
                      startingTimeline: ReportTimeline.week,
                      showcaseKey: timeLineKey,
                    ),
                    const SizedBox(height: 16),
                    ShowcaseWrapper(
                        showcaseKey: suggestionKey,
                        title: "Event Suggestions",
                        description:
                            "Here are some event suggestions based on the data we have collected:\n"
                            "- demography analysis\n"
                            "- time analysis\n"
                            "- space analysis\n"
                            "- event category analysis\n",
                        child: HotelDemographyCard(
                            hotelDemography:
                                AppManagerSingleton.hotelDemography)),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    EventSuggestionCard(
                      suggestions:
                          _reportData[_selectedTimeline]!.suggestionData,
                      onAddEvent: (suggestion) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateEventPage(
                              initialEventTitle:
                                  suggestion.eventTemplate.prefilledTitle,
                              initialEventDescription:
                                  suggestion.eventTemplate.prefilledDescription,
                              initialCategory:
                                  suggestion.eventTemplate.category,
                              initialBadge:
                                  suggestion.eventTemplate.defaultBadge,
                              imageUrl: suggestion.eventTemplate.imageUrl,
                              organizer: AppUserSingleton().currentUser,
                              hotel: LyfHotels.Funan,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ..._reportData[_selectedTimeline]!.cardData.map(
                          (data) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: DashboardCardWidget(data: data),
                          ),
                        ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEventPage(
                organizer: AppUserSingleton().currentUser,
                hotel: LyfHotels.Funan,
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: ShowcaseWrapper(
            showcaseKey: addHotelEvent,
            title: "Create an event as manager",
            description: "Click here to create a special event as a manager.",
            child: const Icon(Icons.add, size: 32)),
      ),
    );
  }
}

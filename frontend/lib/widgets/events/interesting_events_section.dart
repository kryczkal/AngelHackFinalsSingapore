import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_suggestion_engine.dart';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/widgets/events/event_card.dart';
import 'package:frontend/widgets/events/event_recommendation_hint.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';

class InterestingEventsSection extends StatefulWidget {
  final List<Event> events;

  const InterestingEventsSection({
    super.key,
    required this.events,
  });

  @override
  InterestingEventsSectionState createState() =>
      InterestingEventsSectionState();
}

class InterestingEventsSectionState extends State<InterestingEventsSection>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController(viewportFraction: 0.80);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _pageController.addListener(_handlePageChange);
    _animationController.forward();
  }

  void _handlePageChange() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() => _currentPage = page);
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: PageView.builder(
            scrollBehavior: ScrollBehaviorWebExtended(),
            controller: _pageController,
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: EventCard(event: widget.events[index]),
                ),
              );
            },
          ),
        ),
        if (widget.events.isNotEmpty)
          Center(
            child: ShimmeringElegantHint(
              hint: AppSugestionEngine().getPersonalizedHint(
                widget.events[_currentPage],
                AppUserSingleton().currentUser,
              ),
              animation: _animationController,
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_events.dart';
import 'package:frontend/widgets/common/minimum_app_bar.dart';
import 'package:frontend/widgets/events/show_events_widget.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({Key? key}) : super(key: key);
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  static int _enterCount = 0;
  bool _showHint = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isHotelEvents = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _checkAndShowHint();
  }

  void _checkAndShowHint() {
    if (_enterCount < 3) {
      _enterCount++;
      setState(() {
        _showHint = true;
        _animationController.forward();
      });
    }
  }

  void _hideHint() {
    if (_showHint) {
      _animationController.reverse().then((_) {
        setState(() {
          _showHint = false;
        });
      });
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MinimumAppBar(
        title:
            Text(_isHotelEvents ? 'Lyf Organized Events' : 'Community Events'),
      ),
      body: GestureDetector(
        onTap: _hideHint,
        child: Stack(
          children: [
            PageView(
              scrollBehavior:
                  ScrollBehaviorWebExtended().copyWith(scrollbars: false),
              controller: _pageController,
              onPageChanged: (_) {
                _hideHint();
                setState(() {
                  _isHotelEvents = !_isHotelEvents;
                });
              },
              children: [
                ShowEventsWidget(
                    eventsLoader: () => AppEventsSingleton().getHotelEvents()),
                ShowEventsWidget(
                    eventsLoader: () => AppEventsSingleton().getEvents()),
              ],
            ),
            if (_showHint)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      constraints: const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.hotel,
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Discover Community\n Events',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.arrowLeft,
                                size: 16,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Swipe left to discover',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.circleXmark,
                                size: 14,
                                color: Colors.black38,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Tap anywhere to dismiss',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

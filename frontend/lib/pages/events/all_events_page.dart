import 'package:flutter/material.dart';
import 'package:frontend/app_data/app_animations.dart';
import 'package:frontend/pages/events/event_details_page.dart';
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
  final TextEditingController _codeController = TextEditingController();
  String? _errorMessage;
  bool _isCodeEntryVisible = false;
  bool _isHotelEvents = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppAnimations.defaultDurationMs),
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

  void _checkPrivateEvent() {
    final code = _codeController.text.trim();
    final event = AppEventsSingleton().getPrivatePeopleEvent(code);

    if (event != null) {
      setState(() {
        _errorMessage = null;
      });
    

     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsPage(eventDetails: event),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Event does not exists';
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {  
          setState(() {
            _errorMessage = null;
          });
        }
      });
    }
  }


  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MinimumAppBar(
        title: Text(_isHotelEvents ? 'Lyf Hotel Events' : 'Community Events'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isCodeEntryVisible)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: 'Enter private event code',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        errorText: _errorMessage,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 8),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _checkPrivateEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Join', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _isCodeEntryVisible = !_isCodeEntryVisible;
              });
            },
            backgroundColor: Colors.green,
            child: Icon(
              _isCodeEntryVisible ? Icons.remove : Icons.add,
              size: 32,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _hideHint,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView(
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
                        eventsLoader: () =>
                            AppEventsSingleton().getHotelEvents(),
                      ),
                      ShowEventsWidget(
                        eventsLoader: () =>
                            AppEventsSingleton().getPublicPeopleEvents(),
                      ),
                    ],
                  ),
                ),
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

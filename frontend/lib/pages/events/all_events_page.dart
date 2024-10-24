import 'package:flutter/material.dart';
import 'package:frontend/pages/events/event_details_page.dart';
import 'package:frontend/pages/events/show_events_widget.dart';

import '../../app_data/app_events.dart';

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
  late Animation<Offset> _slideAnimation;
  final TextEditingController _codeController = TextEditingController();
  String? _errorMessage;
  bool _isCodeEntryVisible = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _checkAndShowHint();
  }

  void _checkAndShowHint() {
    if (_enterCount < 3) {
      _enterCount++;
      setState(() {
        _showHint = true;
      });
    }
  }

  void _hideHint() {
    setState(() {
      _showHint = false;
    });
  }

  void _checkPrivateEvent() {
    final code = _codeController.text.trim();
    try {
      final event = AppEventsSingleton().getEvents().firstWhere(
            (event) => event.isPrivate && event.password == code,
            orElse: () => throw Exception('Event not found'),
          );

      setState(() {
        _errorMessage = null;
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsPage(eventDetails: event),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Event does not exists';
      });
      // Add timer to clear error message after 5 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {  // Check if widget is still mounted
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
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isCodeEntryVisible)
            Positioned(
              right: 72,
              child: Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Increased vertical padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Join', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
              // please add here some empty space with width 100
               
            ),
            SizedBox(width: 16),

            
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
                    controller: _pageController,
                    onPageChanged: (_) => _hideHint(),
                    children: [
                      ShowEventsWidget(
                          eventsLoader: () => AppEventsSingleton().getEvents().where((event) => !event.isHotelOrganized && !event.isPrivate).toList()),
                      ShowEventsWidget(
                          eventsLoader: () => AppEventsSingleton().getEvents().where((event) => event.isHotelOrganized && !event.isPrivate).toList()),
                    ],
                  ),
                ),
              ],
            ),
            if (_showHint)
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Swipe left for',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'hotel events',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                      const SizedBox(height: 12),
                      SlideTransition(
                        position: _slideAnimation,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

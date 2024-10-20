import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_events.dart';
import 'package:frontend/widgets/show_events_widget.dart';

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
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showHint = false;
          });
        }
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
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              ShowEventsWidget(eventsLoader: () => MockEvents().getEvents()),
              ShowEventsWidget(
                  eventsLoader: () => MockEvents().getHotelEvents()),
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
    );
  }
}

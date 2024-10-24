import 'package:flutter/material.dart';
import 'package:frontend/models/event_suggestion_data.dart';
import 'package:frontend/widgets/misc/app_scroll_behavior_web_extended.dart';

class EventSuggestionCard extends StatefulWidget {
  final List<EventSuggestionData> suggestions;
  final Function(EventSuggestionData) onAddEvent;

  const EventSuggestionCard({
    super.key,
    required this.suggestions,
    required this.onAddEvent,
  });

  @override
  _EventSuggestionCardState createState() => _EventSuggestionCardState();
}

class _EventSuggestionCardState extends State<EventSuggestionCard> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange(int index) {
    setState(() {
      if (index < 0) {
        currentIndex = widget.suggestions.length - 1;
        _pageController.jumpToPage(currentIndex);
      } else if (index >= widget.suggestions.length) {
        currentIndex = 0;
        _pageController.jumpToPage(currentIndex);
      } else {
        currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF66BB6A),
            Color(0xFF43A047),
          ],
        ),
      ),
      child: PageView.builder(
        scrollBehavior: AppScrollBehaviorWebExtended(),
        controller: _pageController,
        onPageChanged: _handlePageChange,
        itemCount: widget.suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = widget.suggestions[index];
          return _buildSuggestionCard(suggestion);
        },
      ),
    );
  }

  Widget _buildSuggestionCard(EventSuggestionData suggestion) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  suggestion.category.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              suggestion.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF4CAF50),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => widget.onAddEvent(suggestion),
                child: const Text(
                  'Show More',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

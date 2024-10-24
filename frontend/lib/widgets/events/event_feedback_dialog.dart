import 'package:flutter/material.dart';
import 'package:frontend/models/event_data.dart';
import 'package:frontend/models/review.dart';

class EventFeedbackDialog extends StatefulWidget {
  final Event event;
  final VoidCallback onClose;

  const EventFeedbackDialog({
    super.key, 
    required this.event,
    required this.onClose,
  });

  @override
  EventFeedbackDialogState createState() => EventFeedbackDialogState();
}

class EventFeedbackDialogState extends State<EventFeedbackDialog> {
  int _rating = 0;
  final TextEditingController _commentsController = TextEditingController();

  void _submitFeedback() {
    final review = Review(
      rating: _rating,
      comments: _commentsController.text.isEmpty ? null : _commentsController.text,
      event: widget.event,
    );

    // TODO: Place to handle the review
    widget.onClose();
  }

  void _closeDialog() {
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You were at event ${widget.event.title}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'How was your experience?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: index < _rating ? Colors.yellow : Colors.blue,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Comments / Thoughts',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentsController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Place for your feedback!',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _closeDialog,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Send!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
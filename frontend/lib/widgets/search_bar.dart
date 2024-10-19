import 'package:flutter/material.dart';

class EventsSearchBar extends StatefulWidget {
  final Function(String) onChanged;

  const EventsSearchBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _EventsSearchBarState createState() => _EventsSearchBarState();
}

class _EventsSearchBarState extends State<EventsSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search events...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

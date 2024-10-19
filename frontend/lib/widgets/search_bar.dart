import 'package:flutter/material.dart';

class EventsSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback onFilterTap;

  const EventsSearchBar({
    Key? key,
    required this.onChanged,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  _EventsSearchBarState createState() => _EventsSearchBarState();
}

class _EventsSearchBarState extends State<EventsSearchBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange(bool hasFocus) {
    if (hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1 + _animation.value * 0.1),
                  blurRadius: 10 + _animation.value * 10,
                  offset: Offset(0, 5 + _animation.value * 5),
                ),
              ],
            ),
            child: child,
          );
        },
        child: Focus(
          onFocusChange: _onFocusChange,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search events...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              widget.onChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
              const SizedBox(width: 10),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: widget.onFilterTap,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.filter_list, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

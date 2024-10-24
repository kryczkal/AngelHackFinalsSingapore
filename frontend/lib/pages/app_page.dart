import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app_data/app_events.dart';
import 'dart:ui';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/manager/manager_dashboard_page.dart';
import 'package:frontend/pages/user_home_page.dart';
import 'package:frontend/widgets/events/event_feedback_dialog.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';
import 'package:frontend/models/event_data.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  FocusNode? _focusNode;
  OverlayEntry? _overlayEntry;
  bool _isOverlayShowing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    if (_isOverlayShowing) {
      _overlayEntry?.remove();
    }
    _focusNode?.dispose();
    super.dispose();
  }

  void _hideDialog() {
    if (_isOverlayShowing) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOverlayShowing = false;
    }
  }

  void _showDialog() {
    if (_isOverlayShowing) {
      return; // Don't show another dialog if one is already showing
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child:  EventFeedbackDialog(
                  event: AppEventsSingleton().events[0],
                  onClose: _hideDialog,
              ),
            ),
          ),
        ),
      ),
    );

    _isOverlayShowing = true;
    Overlay.of(context).insert(_overlayEntry!);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (HardwareKeyboard.instance.isControlPressed &&
          HardwareKeyboard.instance.isAltPressed &&
          event.logicalKey == LogicalKeyboardKey.keyR) {
        if (_isOverlayShowing) {
          _hideDialog();
        } else {
          _showDialog();
        }
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    bool isManager = AppUserSingleton().currentUser.isManager;

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      autofocus: true,
      child: Stack(
        children: [
          Scaffold(
            body: PageView(
              scrollBehavior: ScrollBehaviorWebExtended(),
              children: isManager
                  ? const [
                      UserPage(),
                      ManagerDashboardPage(),
                    ]
                  : const [
                      UserPage(),
                    ],
            ),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
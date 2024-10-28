import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app_data/app_events.dart';
import 'dart:ui';
import 'package:frontend/app_data/app_user.dart';
import 'package:frontend/pages/manager/manager_dashboard_page.dart';
import 'package:frontend/pages/user_home_page.dart';
import 'package:frontend/widgets/events/event_feedback_dialog.dart';
import 'package:frontend/widgets/misc/scroll_behavior_web_extended.dart';
import 'package:frontend/widgets/tutorials/welcome_modal.dart';
import 'package:showcaseview/showcaseview.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  FocusNode? _focusNode;
  OverlayEntry? _overlayEntry;
  bool _isOverlayShowing = false;
  bool _hasShownWelcomeModal = false;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeModal();
    });
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

      // Add a small delay before showing content for a smoother transition
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _showContent = true;
        });
      });
    }
  }

  void _showWelcomeModal() {
    if (_hasShownWelcomeModal) return;
    _hasShownWelcomeModal = true;

    _overlayEntry = OverlayEntry(
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: WelcomeModal(
          isManager: AppUserSingleton().currentUser.isManager,
          onClose: _hideDialog,
        ),
      ),
    );

    _isOverlayShowing = true;
    Overlay.of(context).insert(_overlayEntry!);
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
              child: EventFeedbackDialog(
                event: AppEventsSingleton()
                        .getMyRegisteredEvents(AppUserSingleton().currentUser)
                        .isNotEmpty
                    ? AppEventsSingleton()
                        .getMyRegisteredEvents(AppUserSingleton().currentUser)
                        .first
                    : AppEventsSingleton().events.first,
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
      if (event.logicalKey == LogicalKeyboardKey.escape && _isOverlayShowing) {
        _hideDialog();
        return KeyEventResult.handled;
      }

      if (event.logicalKey == LogicalKeyboardKey.escape) {
        ShowCaseWidget.of(context).dismiss();
      }

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
            body: AnimatedOpacity(
              opacity: _showContent ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: _showContent
                  ? PageView(
                      scrollBehavior: ScrollBehaviorWebExtended(),
                      children: isManager
                          ? const [
                              UserPage(),
                              ManagerDashboardPage(),
                            ]
                          : const [
                              UserPage(),
                            ],
                    )
                  : Container(
                      color: Colors.white,
                    ),
            ),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

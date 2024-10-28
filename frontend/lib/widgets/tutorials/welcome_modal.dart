import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class WelcomeModal extends StatelessWidget {
  final VoidCallback onClose;
  final bool isManager;

  const WelcomeModal({
    Key? key,
    required this.onClose,
    required this.isManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent closing when clicking inside the modal
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isManager
                                ? 'You can swipe left or right to switch between User and Manager pages.'
                                : 'Welcome to the application!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'You can press ESC button to close all tutorials!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: onClose,
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

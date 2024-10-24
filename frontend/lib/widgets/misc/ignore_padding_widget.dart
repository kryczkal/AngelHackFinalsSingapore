import 'package:flutter/material.dart';

class IgnorePaddingWidget extends StatelessWidget {
  final Widget child;

  const IgnorePaddingWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: OverflowBox(
        maxWidth: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}

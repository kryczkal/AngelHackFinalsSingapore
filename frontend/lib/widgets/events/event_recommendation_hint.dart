import 'package:flutter/material.dart';

class RecommendationHint extends StatelessWidget {
  final String hint;
  final Animation<double> animation;

  const RecommendationHint({
    Key? key,
    required this.hint,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 1,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0),
                      Colors.amber.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.grey[800]!,
                    Colors.grey[600]!,
                  ],
                ).createShader(bounds),
                child: Text(
                  hint,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              Container(
                width: 24,
                height: 1,
                margin: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0.7),
                      Colors.amber.withOpacity(0),
                    ],
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

// Optional: Add this shimmer effect variant for extra elegance
class ShimmeringElegantHint extends StatefulWidget {
  final String hint;
  final Animation<double> animation;

  const ShimmeringElegantHint({
    Key? key,
    required this.hint,
    required this.animation,
  }) : super(key: key);

  @override
  State<ShimmeringElegantHint> createState() => _ShimmeringElegantHintState();
}

class _ShimmeringElegantHintState extends State<ShimmeringElegantHint>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _shimmerAnimation = Tween<double>(
      begin: 0.4,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) => RecommendationHint(
        hint: widget.hint,
        animation: widget.animation,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dotColor =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              final value = _controller.value;
              final delay = i * 0.2;
              final opacity = (value - delay).clamp(0.0, 1.0);
              return Opacity(
                opacity: Curves.easeInOut.transform(opacity),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.5),
                  child: CircleAvatar(radius: 4, backgroundColor: dotColor),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

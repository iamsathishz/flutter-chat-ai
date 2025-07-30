import 'dart:ui';
import 'package:flutter/material.dart';

class QuickQuiz extends StatelessWidget {
  final List<String> prompts;
  final void Function(String) onSelected;

  const QuickQuiz({super.key, required this.prompts, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: prompts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final text = prompts[index];

          return InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => onSelected(text),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient:
                    isDark
                        ? const LinearGradient(
                          colors: [
                            Color.fromARGB(80, 255, 255, 255),
                            Color.fromARGB(40, 255, 255, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.85),
                            Colors.grey.shade100.withOpacity(0.9),
                          ],
                        ),
                border: Border.all(
                  color:
                      isDark
                          ? Colors.white.withOpacity(0.15)
                          : Colors.black.withOpacity(0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark
                            ? Colors.black.withOpacity(0.15)
                            : Colors.grey.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

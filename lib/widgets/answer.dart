import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final String? selectedAnswer;
  final String correctAnswer;
  final bool showResult;
  final VoidCallback onTap;

  const Answer({
    super.key,
    required this.answer,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.showResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor = Theme.of(context).colorScheme.surfaceVariant;
    Color? bgColor = baseColor;
    Color borderColor = Colors.transparent;
    Color textColor = Theme.of(context).colorScheme.onSurface;

    if (showResult) {
      if (answer == correctAnswer) {
        bgColor = Colors.green.withValues(alpha: 0.3);
        borderColor = Colors.green;
        textColor = Colors.green[900]!;
      }
      if (answer == selectedAnswer && answer != correctAnswer) {
        bgColor = Colors.red.withValues(alpha: 0.25);
        borderColor = Colors.red;
        textColor = Colors.red[900]!;
      }
    } else if (answer == selectedAnswer) {
      bgColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.15);
      borderColor = Theme.of(context).colorScheme.primary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: showResult ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
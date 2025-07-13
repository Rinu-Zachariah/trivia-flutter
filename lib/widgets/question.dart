import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import 'answer.dart';

class Question extends StatelessWidget {
  final TriviaQuestion question;
  final String? selectedAnswer;
  final bool showResult;
  final ValueChanged<String> onAnswerSelected;

  const Question({
    required this.question,
    required this.selectedAnswer,
    required this.showResult,
    required this.onAnswerSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
              ...question.allAnswers.map(
                (a) => Answer(
                  answer: a,
                  selectedAnswer: selectedAnswer,
                  correctAnswer: question.correctAnswer,
                  showResult: showResult,
                  onTap: () => onAnswerSelected(a),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
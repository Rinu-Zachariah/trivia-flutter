import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_flutter/models/trivia_question.dart';

void main() {
  test('TriviaQuestion fromMap parses data correctly', () {
    final sample = {
      'question': 'What is 2 + 2?',
      'correct_answer': '4',
      'incorrect_answers': ['2', '3', '5'],
    };

    final question = TriviaQuestion.fromMap(sample);

    expect(question.question, 'What is 2 + 2?');
    expect(question.correctAnswer, '4');
    expect(question.allAnswers.length, 4); // 1 correct + 3 incorrect
    expect(question.allAnswers, contains('4'));
  });
}
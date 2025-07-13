import 'package:trivia_flutter/models/trivia_question.dart';
import 'package:trivia_flutter/services/trivia_api_service.dart';

class MockTriviaApiService implements TriviaApiService {
  @override
  Future<List<TriviaQuestion>> fetchQuestions({int amount = 5}) async {
    // Return fake data instantly
    return [
      TriviaQuestion(
        question: "What is 2+2?",
        correctAnswer: "4",
        allAnswers: ["2", "3", "4", "5"],
      )
    ];
  }
}
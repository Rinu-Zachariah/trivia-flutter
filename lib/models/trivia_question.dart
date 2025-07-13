class TriviaQuestion {
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;

  TriviaQuestion({
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
  });

  factory TriviaQuestion.fromMap(Map<String, dynamic>map) {
    String decode(String input) => input
      .replaceAll('&quot;', '"')
      .replaceAll('&#039;', "'")
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>');
    
    final question = decode(map['question']);
    final correct = decode(map['correct_answer']);
    final incorrect = (map['incorrect_answers'] as List)
      .map<String>((incorrectValue) => decode(incorrectValue))
      .toList();

    final answers = [...incorrect, correct]..shuffle();
    return TriviaQuestion(
      question: question,
      correctAnswer: correct,
      allAnswers: answers,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_flutter/screens/flashcard.dart';
import 'mock_trivia_api_service.dart';

void main() {
  testWidgets('Score updates after answering', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Flashcard(triviaApiService: MockTriviaApiService()),
    ));

    await tester.pumpAndSettle();

    // Tap the correct answer (which is always "4" in the mock)
    final answerButton = find.text('4');
    await tester.tap(answerButton);
    await tester.pumpAndSettle();

    // Check that the score updates (e.g., "Score: 1")
    expect(find.textContaining("Score: 1"), findsOneWidget);
  });
}
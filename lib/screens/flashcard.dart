import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import '../services/trivia_api_service.dart';
import '../widgets/question.dart';

class Flashcard extends StatefulWidget {
  final TriviaApiService triviaApiService;
  Flashcard({
    Key? key,
    TriviaApiService? triviaApiService,
  }) : triviaApiService = triviaApiService ?? TriviaApiService(),
        super(key: key);

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  List<TriviaQuestion> _questions = [];
  int _currentIdx = 0;
  String? _selectedAnswer;
  bool _showResult = false;
  bool _isLoading = true;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
      _questions = [];
      _currentIdx = 0;
      _score = 0;
    });
    try {
      final qs = await widget.triviaApiService.fetchQuestions(amount: 10);
      setState(() {
        _questions = qs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showError(context, e.toString());
    }
  }

  void _onAnswerSelected(String answer) {
    if (_showResult) return;
    final isCorrect = answer == _questions[_currentIdx].correctAnswer;
    setState(() {
      _selectedAnswer = answer;
      _showResult = true;
      if (isCorrect) _score++;
    });
  }

  void _onNext() {
    if (_currentIdx < _questions.length - 1) {
      setState(() {
        _currentIdx++;
        _selectedAnswer = null;
        _showResult = false;
      });
    } else {
      _showFinalScore();
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Complete!"),
        content: Text("You scored $_score out of ${_questions.length}"),
        actions: [
          TextButton(
            child: const Text("Restart"),
            onPressed: () {
              Navigator.of(context).pop();
              _loadQuestions();
            },
          )
        ],
      ),
    );
  }

  void _showError(BuildContext context, String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $msg")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: _loadQuestions,
            child: const Text("Retry"),
          ),
        ),
      );
    }
    final q = _questions[_currentIdx];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia Games'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadQuestions,
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${_currentIdx + 1} of ${_questions.length}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Question(
                    question: q,
                    selectedAnswer: _selectedAnswer,
                    showResult: _showResult,
                    onAnswerSelected: _onAnswerSelected,
                  ),
                  const SizedBox(height: 18),
                  if (_showResult)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onNext,
                        child: Text(_currentIdx == _questions.length - 1
                            ? 'Finish'
                            : 'Next'),
                      ),
                    ),
                  Text(
                    "Score: $_score",
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
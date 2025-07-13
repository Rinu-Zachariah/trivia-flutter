import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/trivia_question.dart';

const String apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://opentdb.com/api.php');

class TriviaApiService {
  Future<List<TriviaQuestion>> fetchQuestions({int amount = 5}) async {
    final url = Uri.parse('$apiUrl?amount=$amount&type=multiple');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final results = body['results'] as List;
      return results
          .map((q) => TriviaQuestion.fromMap(q))
          .toList(growable: false);
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
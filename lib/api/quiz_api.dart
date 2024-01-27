import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:waterflow_intern/models/quiz.dart';

class QuizApi {
  static Uri quizUrl = Uri.parse("https://the-trivia-api.com/v2/questions");

  static Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  static Future<List<Quiz>> getQuizQuestions() async {
    try {
      final response = await http.get(
        quizUrl,
        headers: header,
      );

      List<dynamic> quizList = json.decode(response.body);
      List<Quiz> quizQuestions = [];
      for (final item in quizList) {
        List<String> answers = [];
        answers.add(item['correctAnswer']);

        List<dynamic> options = item['incorrectAnswers'];
        for (final option in options) {
          answers.add(option);
        }

        final question = Quiz(
          question: item['question']['text'],
          answerOptions: answers,
          correctAnswer: item['correctAnswer'],
          id: item['id'],
        );
        // print(question.question);
        // print(question.answerOptions);
        // print(question.correctAnswer);
        // print(question.id);
        quizQuestions.add(question);
      }
      return quizQuestions;
    } catch (error) {
      print(error);
      return [];
    }
  }
}

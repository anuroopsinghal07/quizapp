import 'package:quizapp/Model/question.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class QuizDataProvider {
  Future<Question?> fetchQuestions(int questionNo) async {
    try {
      var jsonText =
          await rootBundle.loadString('assets/question$questionNo.json');
      return _parseJsonText(jsonText);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<Question> _parseJsonText(String jsonText) {
    try {
      List list = json.decode(jsonText);
      List<Question?> questionList = <Question>[];

      for (var element in list) {
        questionList.add(Question.fromJson(element));
      }

      return questionList.isNotEmpty
          ? Future.value(questionList.first)
          : Future.value(null);
    } catch (_) {
      throw Exception('failed to load questions');
    }
  }
}

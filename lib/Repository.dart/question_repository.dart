import 'package:quizapp/DataProvider/quiz_data_provider.dart';
import 'package:quizapp/Model/question.dart';

class QuestionRepository {
  final QuizDataProvider _quizDataProvider = QuizDataProvider();

  Future<Question?> fetchQuestions(int questionNo) =>
      _quizDataProvider.fetchQuestions(questionNo);
}

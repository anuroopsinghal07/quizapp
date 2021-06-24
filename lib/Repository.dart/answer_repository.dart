import 'package:quizapp/DataProvider/answer_data_provider.dart';
import 'package:quizapp/Model/answer.dart';

class AnswerRepository {
  final AnswerDataProvider _answerDataProvider = AnswerDataProvider();

  Future<List<Answer>> fetchAnswers() =>
      _answerDataProvider.getAllAnswersFromDB();

  Future<bool> addAnswer(Answer answer) =>
      _answerDataProvider.addAnswerInDB(answer);
}

import 'package:quizapp/Model/answer.dart';
import 'package:quizapp/database/db_provider.dart';

class AnswerDataProvider {
  Future<bool> addAnswerInDB(Answer answer) async {
    print("addAnswerInDB : $answer");
    try {
      final db = await DBProvider.db.database;
      await db.insert(getTableName(), answer.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAnswersInDB() async {
    try {
      final db = await DBProvider.db.database;
      await db.delete(getTableName());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Answer>> getAllAnswersFromDB() async {
    final db = await DBProvider.db.database;
    final res = await db.rawQuery('SELECT * FROM ${getTableName()}');
    List<Answer> list =
        res.isNotEmpty ? res.map((c) => Answer.fromMap(c)).toList() : [];

    //return List.from(list.reversed);
    return list;
  }

  String getTableName() {
    return "Answer";
  }
}

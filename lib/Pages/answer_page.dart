import 'package:flutter/material.dart';
import 'package:quizapp/Utility/utility.dart';
import 'package:quizapp/widgets/answer_box.dart';
import 'package:quizapp/Model/question.dart';

class AnswerPage extends StatelessWidget {
  final Options option;
  final AnswersViewType answersViewType;

  final double gridHeight;
  final double gridWidth;

  final bool isUserSelection;

  const AnswerPage(
      {required this.option,
      required this.answersViewType,
      required this.gridHeight,
      required this.gridWidth,
      required this.isUserSelection,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnswerBox(
        option: option,
        answersViewType: answersViewType,
        gridHeight: gridHeight,
        gridWidth: gridWidth,
        isUserSelection: isUserSelection,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/Bloc/questions_bloc.dart';
import 'package:quizapp/Pages/question_page.dart';
import 'package:quizapp/Pages/quiz_summary_page.dart';
import 'package:quizapp/Utility/constant.dart';
import 'package:quizapp/widgets/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int _questionIndex = 1;
  bool _displayQuestion = false;

  @override
  void initState() {
    super.initState();

    initiateQuestionFetch();
  }

  initiateQuestionFetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(currentQuestionNoKey)) {
      _questionIndex = prefs.getInt(currentQuestionNoKey)!;
    } else {
      prefs.setInt(currentQuestionNoKey, _questionIndex);
    }

    BlocProvider.of<QuestionsBloc>(context)
        .add(QuestionsFetchEvent(questionNo: _questionIndex));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print("questions build");
    return BlocBuilder(
      bloc: BlocProvider.of<QuestionsBloc>(context),
      builder: (context, state) {
        if (state is QuestionsUninitializedState) {
          return const Message(message: "Wait...");
        } else if (state is QuestionsEmptyState) {
          return const QuizSummaryPage();
        } else if (state is QuestionsErrorState) {
          return const Message(message: "Something went wrong");
        } else if (state is QuestionsFetchingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          print("QuestionPage");
          final stateAsQuestionsFetchedState = state as QuestionsFetchedState;
          final question = stateAsQuestionsFetchedState.question;
          var _question = question;
          return QuestionPage(
            question: _question,
          );
        }
      },
    );
  }

  // Widget _buildQuestion(Question question) {
  //   print("_displayQuestion : $_displayQuestion");
  //   return _displayQuestion
  //       ? const QuestionWidget()
  //       : GetReady(
  //           onCompletion: () {
  //             print("onEnd called");
  //             setState(() {
  //               _displayQuestion = true;
  //             });
  //           },
  //         );
  // }
}

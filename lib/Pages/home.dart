import 'package:flutter/material.dart';
import 'package:quizapp/Bloc/answers_bloc.dart';
import 'package:quizapp/Bloc/questions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/Pages/questions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    //fetchQuestions();
  }

  // fetchQuestions() async {
  //   var questions = await QuizDataProvider().fetchQuestions();
  //   debugPrint("questions: $questions");
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          QuestionsBloc(QuestionsUninitializedState()),
      child: BlocProvider(
        create: (BuildContext context) =>
            AnswerBloc(AnswerUninitializedState()),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: const Questions(),
        ),
      ),
    );

    // return Scaffold(
    //   key: widget.key,
    //   body: const Text('data'),
    // );
  }
}

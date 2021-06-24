import 'package:flutter/material.dart';
import 'package:quizapp/Bloc/answers_bloc.dart';
import 'package:quizapp/Bloc/questions_bloc.dart';
import 'package:quizapp/DataProvider/answer_data_provider.dart';
import 'package:quizapp/Model/answer.dart';
import 'package:quizapp/Utility/constant.dart';
import 'package:quizapp/widgets/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizSummaryPage extends StatelessWidget {
  const QuizSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build QuizSummaryPage");

    BlocProvider.of<AnswerBloc>(context).add(AnswerFetchEvent());

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: BlocBuilder(
            bloc: BlocProvider.of<AnswerBloc>(context),
            builder: (context, state) {
              if (state is AnswerUninitializedState) {
                return const Message(message: "Wait...");
              } else if (state is AnswerEmptyState) {
                return const Message(message: "No data to show");
              } else if (state is AnswerErrorState) {
                return const Message(message: "Something went wrong");
              } else if (state is AnswerFetchingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final stateAsAnswerFetchedState = state as AnswerFetchedState;
                final answers = stateAsAnswerFetchedState.answers;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Quiz Summary',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .color)),
                      _buildListView(answers),
                      ElevatedButton(
                        onPressed: () {
                          restartQuiz(context);
                        },
                        child: const Text(
                          'Restart Quiz',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  Widget _buildListView(List<Answer> answers) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: answers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                'Question ${index + 1}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline6!.color),
              ),
              subtitle: Text(
                  'Score : ${answers[index].score}  Time: ${answers[index].time} seconds',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.headline6!.color)),
            );
          }),
    );
  }

  // Center(
  //   child: TextButton(
  //     onPressed: () {
  //       restartQuiz(context);
  //     },
  //     child: const Text('Restart Quiz'),
  //   ),
  // ),

  restartQuiz(BuildContext context) async {
    AnswerDataProvider().deleteAnswersInDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(currentQuestionNoKey, 1);

    BlocProvider.of<QuestionsBloc>(context)
        .add(QuestionsFetchEvent(questionNo: 1));
  }
}

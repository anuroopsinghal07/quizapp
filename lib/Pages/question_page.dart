import 'package:flutter/material.dart';
import 'package:quizapp/DataProvider/settings_data_provider.dart';
import 'package:quizapp/Model/question.dart';
import 'package:quizapp/Model/settings.dart';
import 'package:quizapp/Pages/settings_page.dart';
import 'package:quizapp/widgets/get_ready.dart';
import 'package:quizapp/widgets/question_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quizapp/Utility/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/Bloc/questions_bloc.dart';

class QuestionPage extends StatefulWidget {
  final Question question;

  const QuestionPage({required this.question, Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool _showGetReadyAnimation = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  @override
  void didUpdateWidget(covariant QuestionPage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
    _isLoading = true;
    _fetchInitialData();
  }

  _fetchInitialData() async {
    Settings settings = await SettingsDataProvider().fetchSettings();
    _showGetReadyAnimation = settings.showGetReadyAnimation;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : !_showGetReadyAnimation
            ? SafeArea(
                child: Stack(
                  children: [
                    QuestionWidget(
                      question: widget.question,
                    ),
                    Positioned(
                        left: 10,
                        child: ClipOval(
                          child: Material(
                            color: Colors.blue, // Button color
                            child: InkWell(
                              splashColor: Colors.red, // Splash color
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage(),
                                      fullscreenDialog: true),
                                );

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                int _questionIndex = 1;

                                if (prefs.containsKey(currentQuestionNoKey)) {
                                  _questionIndex =
                                      prefs.getInt(currentQuestionNoKey)!;
                                } else {
                                  prefs.setInt(
                                      currentQuestionNoKey, _questionIndex);
                                }

                                BlocProvider.of<QuestionsBloc>(context).add(
                                    QuestionsFetchEvent(
                                        questionNo: _questionIndex));
                              },
                              child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            : GetReady(
                onCompletion: () {
                  print("onEnd called");
                  setState(() {
                    _showGetReadyAnimation = false;
                  });
                },
              );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizapp/Bloc/answers_bloc.dart';
import 'package:quizapp/Bloc/questions_bloc.dart';
import 'package:quizapp/DataProvider/settings_data_provider.dart';
import 'package:quizapp/Model/answer.dart';
import 'package:quizapp/Model/question.dart';
import 'package:quizapp/Model/settings.dart';
import 'package:quizapp/Pages/answer_page.dart';
import 'package:quizapp/Utility/constant.dart';
import 'package:quizapp/Utility/utility.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:quizapp/widgets/message.dart';
import 'package:quizapp/widgets/option_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;

  const QuestionWidget({required this.question, Key? key}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int _duration = 0;
  late List<Options>? options;
  late AnswersViewType _answersViewType;
  bool _isLoading = true;
  double gridHeight = 0.0;
  double gridWidth = 0.0;

  final CountDownController _controller = CountDownController();
  late Settings _settings;
  late PausableTimer timer;

  @override
  void dispose() {
    //_controller.pause();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getInitialData();
  }

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoading = true;

    getInitialData();
  }

  getInitialData() async {
    options = widget.question.data?.options;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    //prefs.setInt(answersViewTypeKey, AnswersViewType.grid.index);

    if (prefs.containsKey(answersViewTypeKey)) {
      _answersViewType =
          AnswersViewType.values[prefs.getInt(answersViewTypeKey)!];
    } else {
      prefs.setInt(answersViewTypeKey, AnswersViewType.grid.index);
      _answersViewType = AnswersViewType.grid;
    }

    _settings = await SettingsDataProvider().fetchSettings();

    // final height = MediaQuery.of(context).size.height;

    // if (_settings.showTimer) {
    //   gridHeight = height * 0.3;
    // } else {
    //   gridHeight = height * 0.6;
    // }

    if (!_settings.showTimer) {
      timer = PausableTimer(const Duration(seconds: 1), () {
        print("time : ${timer.tick}");
        timer
          ..reset()
          ..start();
      });
      timer.start();
    }

    _duration = _settings.timerDuration;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final orientation = MediaQuery.of(context).orientation;

    if (_isLoading == false) {
      if (_settings.showTimer) {
        if (orientation == Orientation.portrait) {
          gridWidth = width;
          gridHeight = height * 0.3;
        } else {
          gridWidth = width * 0.6;
          gridHeight = height * 0.6;
        }
      } else {
        if (orientation == Orientation.portrait) {
          gridWidth = width;
          gridHeight = height * 0.3;
        } else {
          gridHeight = height * 0.6;

          gridWidth = width * 0.8;
        }
      }

      print("gridWidth $gridWidth");
    }

    return SafeArea(
      child: _isLoading
          ? const Message(message: "Please wait..")
          : SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                    child: Center(
                      child: AutoSizeText(
                        'Question!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                    child: Center(
                      child: AutoSizeText(
                        widget.question.data?.stimulus?.parseHtmlString() ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.headline6!.color,
                        ),
                      ),
                    ),
                  ),
                  if (orientation == Orientation.portrait)
                    if (_settings.showTimer)
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: height * 0.2,
                        child: Center(
                          child: _buildCircularCountDownTimer(height * 0.2),
                        ),
                      ),
                  if (orientation == Orientation.portrait)
                    Expanded(
                      //height: gridHeight,
                      child: Center(
                        child: _buildOptionsGrid(gridHeight, gridWidth),
                      ),
                    ),
                  if (orientation == Orientation.landscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: gridWidth,
                          height: gridHeight,
                          child: Center(
                            child: _buildOptionsGrid(gridHeight, gridWidth),
                          ),
                        ),
                        if (_settings.showTimer)
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: gridHeight,
                            child: Center(
                              child: _buildCircularCountDownTimer(height * 0.4),
                            ),
                          ),
                      ],
                    )
                ],
              ),
            ),
    );
  }

  Widget _buildCircularCountDownTimer(double boxHeight) {
    print("_buildCircularCountDownTimer");
    return CircularCountDownTimer(
      duration: _duration,
      initialDuration: 0,
      controller: _controller,
      width: boxHeight,
      height: boxHeight,
      ringColor: Colors.grey.shade400,
      ringGradient: null,
      fillColor: Colors.red,
      fillGradient: null,
      backgroundColor: Colors.transparent,
      backgroundGradient: null,
      strokeWidth: 5.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        print('Countdown Ended');

        final correctOption =
            options!.firstWhere((element) => element.isCorrect == 1);

        _showAnswerBox(correctOption, false);
      },
    );
  }

  Widget _buildOptionsGrid(double boxHeight, double boxWidth) {
    double itemHeight = 0;
    double itemWidth = 0;
    int crossAxisCount = 0;
    // final screenWidth = MediaQuery.of(context).size.width;
    if (_answersViewType == AnswersViewType.grid) {
      itemHeight = (boxWidth / 2);
      itemWidth = (boxHeight / 2);
      crossAxisCount = 2;
    } else if (_answersViewType == AnswersViewType.vertical) {
      itemHeight = (boxWidth / 2);
      itemWidth = (boxHeight / 8);
      crossAxisCount = 1;
    } else if (_answersViewType == AnswersViewType.horizontal) {
      itemHeight = (boxWidth / 2);
      itemWidth = (boxHeight / 2);
      crossAxisCount = 1;
    }

    return GridView.builder(
      itemCount: options != null ? options!.length : 0,
      scrollDirection: _answersViewType == AnswersViewType.horizontal
          ? Axis.horizontal
          : Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: (itemHeight / itemWidth)),
      itemBuilder: (BuildContext context, int index) {
        final option = options![index];
        return InkWell(
          onTap: () async {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => AnswerPage(
            //           option: option,
            //           answersViewType: _answersViewType,
            //           gridHeight: gridHeight)),
            // );

            _showAnswerBox(option, true);
          },
          child: AnimationConfiguration.staggeredGrid(
            columnCount: index,
            position: index,
            duration: const Duration(milliseconds: 375),
            child: ScaleAnimation(
              scale: 0.5,
              child: SlideAnimation(
                child: OptionBox(option: option),
              ),
            ),
          ),
        );
      },
    );
  }

  _showAnswerBox(Options option, bool isUserSelection) async {
    if (_settings.showTimer) {
      _controller.pause();
    } else {
      timer.pause();
    }
    final popped = await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AnswerPage(
            option: option,
            answersViewType: _answersViewType,
            gridHeight: gridHeight,
            gridWidth: gridWidth,
            isUserSelection: isUserSelection,
          );
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var questionIndex = prefs.getInt(currentQuestionNoKey)!;

    if (popped) {
      Answer answer;

      if (option.isCorrect == 1) {
        if (isUserSelection) {
          int marks = 0;
          if (widget.question.data != null &&
              widget.question.data!.marks != null) {
            marks = widget.question.data!.marks!;
          }

          int elapsedTime = 0;

          if (_settings.showTimer) {
            final time = _controller.getTime();
            final array = time.split(':');
            int currentTimeInSeconds =
                int.parse(array.first) * 60 + int.parse(array.last);
            elapsedTime = _duration - currentTimeInSeconds;
          } else {
            int currentTimeInSeconds = timer.tick;
            elapsedTime = currentTimeInSeconds;

            timer.cancel();
          }

          print("currentTimeInSeconds $elapsedTime");
          //print("_duration $_duration");

          answer = Answer(
              questionId: widget.question.questionID ?? "",
              score: marks,
              time: elapsedTime);
        } else {
          answer = Answer(
              questionId: widget.question.questionID ?? "",
              score: 0,
              time: _duration);
        }

        BlocProvider.of<AnswerBloc>(context)
            .add(AnswerAddEvent(answer: answer));

        prefs.setInt(currentQuestionNoKey, questionIndex + 1);

        BlocProvider.of<QuestionsBloc>(context)
            .add(QuestionsFetchEvent(questionNo: questionIndex + 1));
      } else {
        if (_settings.showTimer) {
          _controller.resume();
        } else {
          timer
            ..reset()
            ..start();
        }
      }
    }
  }
}

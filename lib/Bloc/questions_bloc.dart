import 'package:quizapp/Repository.dart/question_repository.dart';
import 'package:quizapp/Model/question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class QuestionsEvent {}

class QuestionsFetchEvent extends QuestionsEvent {
  final int questionNo;
  QuestionsFetchEvent({required this.questionNo});
}

abstract class QuestionsState {}

class QuestionsUninitializedState extends QuestionsState {}

class QuestionsFetchingState extends QuestionsState {}

class QuestionsFetchedState extends QuestionsState {
  final Question question;
  QuestionsFetchedState({required this.question});
}

class QuestionsErrorState extends QuestionsState {}

class QuestionsEmptyState extends QuestionsState {}

class QuestionsBloc extends Bloc<QuestionsFetchEvent, QuestionsState> {
  final QuestionRepository questionRepository = QuestionRepository();

  QuestionsBloc(QuestionsState initialState) : super(initialState);
  //QuestionsBloc({this.questionRepository}) : assert(questionRepository != null);
  @override
  void onTransition(
      Transition<QuestionsFetchEvent, QuestionsState> transition) {
    super.onTransition(transition);
  }

  // @override
  // QuestionsState get initialState => QuestionsUninitializedState();

  @override
  Stream<QuestionsState> mapEventToState(QuestionsFetchEvent event) async* {
    yield QuestionsFetchingState();
    Question? question;
    try {
      question = await questionRepository.fetchQuestions(event.questionNo);
      if (question == null) {
        yield QuestionsEmptyState();
      } else {
        yield QuestionsFetchedState(question: question);
      }
    } catch (e) {
      yield QuestionsErrorState();
    }
  }
}

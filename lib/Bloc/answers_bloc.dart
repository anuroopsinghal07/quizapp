import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/Model/answer.dart';
import 'package:quizapp/Repository.dart/answer_repository.dart';

abstract class AnswerEvent {}

class AnswerFetchEvent extends AnswerEvent {}

class AnswerAddEvent extends AnswerEvent {
  final Answer answer;
  AnswerAddEvent({required this.answer});
}

abstract class AnswerState {}

class AnswerUninitializedState extends AnswerState {}

class AnswerFetchingState extends AnswerState {}

class AnswerFetchedState extends AnswerState {
  final List<Answer> answers;
  AnswerFetchedState({required this.answers});
}

class AnswerErrorState extends AnswerState {}

class AnswerEmptyState extends AnswerState {}

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final AnswerRepository answerRepository = AnswerRepository();

  AnswerBloc(AnswerState initialState) : super(initialState);
  @override
  void onTransition(Transition<AnswerEvent, AnswerState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AnswerState> mapEventToState(AnswerEvent event) async* {
    yield AnswerFetchingState();
    List<Answer> answers;
    try {
      //print("event : $event");
      if (event is AnswerAddEvent) {
        // print("event.answer.score : ${event.answer.score}");
        await answerRepository.addAnswer(event.answer);
      }

      answers = await answerRepository.fetchAnswers();
      if (answers.isEmpty) {
        yield AnswerEmptyState();
      } else {
        yield AnswerFetchedState(answers: answers);
      }
    } catch (e) {
      yield AnswerErrorState();
    }
  }
}

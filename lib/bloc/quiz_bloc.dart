import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptesting/bloc/quiz_event.dart';
import 'package:ptesting/bloc/quiz_state.dart';
import 'package:ptesting/repository/repository.dart';


class QuizBloc extends Bloc<QuizEvent, QuizState> {

final Repository repository;

QuizBloc({@required this.repository}) : assert(repository != null);


  @override
  QuizState get initialState => QuizInitioalState();

  @override
  Stream<QuizState> mapEventToState(
      QuizEvent event,
  ) async* {
    if (event is GetQuizEvent) {
      yield QuizLoadingState();
      try{
        final quizModels = await repository
            .getQuizItem(event.quizId);
        print(quizModels);
        yield quizModels.isEmpty ? QuizEmptyState() : QuizLoadedState(quizModels: quizModels);
      }
      catch(e){
        print(e);
        yield QuizErrorState();
      }
    }
    else if(event is GetQuizListEvent){
      yield QuizLoadingState();
      try{
        final quizListModels = await repository
            .getAllQuiz();
        print(quizListModels);
        yield quizListModels.isEmpty ? QuizEmptyState() : QuizListLoadedState(quizListModel: quizListModels);
      }
      catch(e){
        print(e);
        yield QuizErrorState();
      }
    }
    /*else if(event is UpdateReminderEvent){
      try{
        var result = await alarmRepository
            .updateReminder(event.reminder);
        var reminders = await alarmRepository
            .fetchReminders();
        print(result);
        yield reminders.isEmpty ? ReminderEmptyState() : ReminderUpdateState(reminders: reminders, result: result);
      }
      catch(_){
        yield ReminderErrorState();
      }

    }
    else if(event is DeleteReminderEvent){
      try{
        var result = await alarmRepository
            .deleteReminders(event.reminder);
        var reminders = await alarmRepository
            .fetchReminders();
        print(result);
        yield reminders.isEmpty ? ReminderEmptyState() : ReminderDeleteOrInsertState(reminders: reminders, result: result);
      }
      catch(_){
        yield ReminderErrorState();
      }

    }
    else if(event is InsertReminderEvent){
      try{
        var result = await alarmRepository
            .insertReminders(event.reminder);
        var reminders = await alarmRepository
            .fetchReminders();
        print(result);
        yield reminders.isEmpty ? ReminderEmptyState() : ReminderDeleteOrInsertState(reminders: reminders, result: result);
      }
      catch(_){
        yield ReminderErrorState();
      }

    }*/
  }
}

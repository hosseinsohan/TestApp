
import 'package:flutter/material.dart';
import 'package:ptesting/model/QuizListModel.dart';
import 'package:ptesting/model/QuizModel.dart';

@immutable
abstract class QuizState {}

class QuizInitioalState extends QuizState {}
class QuizEmptyState extends QuizState {}
class QuizLoadingState extends QuizState {}
class QuizLoadedState extends QuizState {
  final List<QuizModel> quizModels;
  QuizLoadedState({this.quizModels});
}

class QuizListLoadedState extends QuizState {
  final List<QuizListModel> quizListModel;
  QuizListLoadedState({this.quizListModel});
}
/*class ReminderUpdateState extends QuizState {
  final List<Reminder> reminders;
  final bool result;
  ReminderUpdateState({this.reminders, this.result});
}
class ReminderDeleteOrInsertState extends QuizState {
  final List<Reminder> reminders;
  final int result;
  ReminderDeleteOrInsertState({this.reminders, this.result});
}*/
class QuizErrorState extends QuizState {}

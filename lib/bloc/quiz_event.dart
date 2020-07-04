
import 'package:flutter/material.dart';
import 'package:ptesting/model/QuizModel.dart';

@immutable
abstract class QuizEvent {}

/*class GetReminderEvent extends QuizEvent{}
class UpdateReminderEvent extends ReminderEvent{
  final Reminder reminder;
  UpdateReminderEvent({this.reminder});
}
class DeleteReminderEvent extends ReminderEvent{
  final Reminder reminder;
  DeleteReminderEvent({this.reminder});
}*/
class GetQuizEvent extends QuizEvent{
  final int quizId;
  GetQuizEvent({this.quizId});
}

class GetQuizListEvent extends QuizEvent{
  GetQuizListEvent();
}
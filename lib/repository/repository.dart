import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ptesting/model/QuizListModel.dart';
import 'package:ptesting/model/QuizModel.dart';
import 'package:ptesting/repository/database_helper.dart';


class Repository {
  DatabaseHelper database;

  Repository({@required this.database, })
      : assert(database != null);

  Future<List<QuizListModel>> getAllQuiz() async {
    return await database.getAllQuiz();
  }

  Future<bool> updateQuiz(QuizListModel quizListModel) async {
    return await database.updateQuiz(quizListModel);
  }

  Future<int> deleteQuiz(QuizListModel quizListModel) async {
    return await database.deleteQuiz(quizListModel);
  }

  Future<int> insertQuiz(QuizListModel quizListModel) async {
    return await database.saveQuiz(quizListModel);
  }

  Future<int> insertQuizItem(QuizModel quizModel) async {
    return await database.saveItem(quizModel);
  }

  Future<List<QuizModel>> getQuizItem(int quizId) async {
    return await database.getItem(quizId);
  }
}
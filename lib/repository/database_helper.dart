import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ptesting/model/QuizListModel.dart';
import 'package:ptesting/model/QuizModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "quizdb.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""
            CREATE TABLE item (
              id INTEGER PRIMARY KEY,
              strong_id INTEGER NOT NULL, 
              title Text NOT NULL,
              test INTEGER NOT NULL,
              code INTEGER NOT NULL,
              quiz_id INTEGER NOT NULL
            )""");
    await db.execute("CREATE TABLE quiz (id INTEGER PRIMARY KEY, name TEXT NOT NULL)");
  }

  Future<int> saveQuiz(QuizListModel quizListModel) async {
    var dbClient = await db;
    int results = await dbClient.insert("quiz", quizListModel.toJson());

    return results;
  }

  Future<List<QuizListModel>> getAllQuiz() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM quiz');
    List<QuizListModel> quizListModels = new List();

    for (int i = 0; i < list.length; i++) {
      var quiz = new QuizListModel(
        name: list[i]["name"],
      );
      quiz.setId(list[i]["id"]);
      quizListModels.add(quiz);
    }

    print("اندازه تست ها ${quizListModels.length}");
    return quizListModels;
  }

  Future<int> deleteQuiz(QuizListModel quizListModel) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM quiz WHERE id = ?', [quizListModel.id]);

    return res;
  }

  Future<bool> updateQuiz(QuizListModel quizListModel) async {
    var dbClient = await db;
    int res = await dbClient.update("quiz", quizListModel.toJson(),
        where: "id = ?", whereArgs: <int>[quizListModel.id]);

    return res > 0 ? true : false;
  }

  Future<int> saveItem(QuizModel quizModel) async {
    var dbClient = await db;
    int results = await dbClient.insert("item", quizModel.toJson());

    return results;
  }

  Future<List<QuizModel>> getItem(int quizId) async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM item WHERE quiz_id = ?', [quizId]);
    List<QuizModel> quizModels = new List();

    for (int i = 0; i < list.length; i++) {
      var quizItem = new QuizModel(
          title: list[i]["title"],
          test: list[i]["test"],
          code: list[i]["code"],
          strongId: list[i]["strong_id"],
          quizId: list[i]["quiz_id"]);

      quizItem.setId(list[i]["id"]);

      quizModels.add(quizItem);
    }

    print("اندازه ایتم تست هاا ${quizModels.length}");
    return quizModels;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptesting/bloc/quiz_bloc.dart';
import 'package:ptesting/bloc/quiz_event.dart';
import 'package:ptesting/bloc/quiz_state.dart';
import 'package:ptesting/model/QuizListModel.dart';
import 'package:ptesting/page/show_quiz_items.dart';
import 'package:ptesting/repository/database_helper.dart';
import 'package:ptesting/repository/repository.dart';

class ShowQuizTest extends StatefulWidget {
  @override
  _ShowQuizTest createState() => _ShowQuizTest();
}

class _ShowQuizTest extends State<ShowQuizTest> {
  Future<void> _updateData() async {
    setState(() {
      BlocProvider.of<QuizBloc>(context).add(GetQuizListEvent());
    });
  }

  void callback() {
    setState(() {
      BlocProvider.of<QuizBloc>(context).add(GetQuizListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: _updateData,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child:
                    BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
                  if (state is QuizInitioalState) {
                    BlocProvider.of<QuizBloc>(context).add(GetQuizListEvent());
                  } else if (state is QuizEmptyState) {
                    return Scaffold(
                          appBar: AppBar(
                            title: Text("لیست تست های انجام شده"),
                            backgroundColor: Color.fromRGBO(138, 35, 135, 1.0),
                          ),
                          body: Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'لیست بایگانی خالیست',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Image.asset(
                                  "assets/img/empty.png",
                                  height: 150,
                                ),
                                ListTile(
                                  title: Text("توضیح:"),
                                  subtitle: Text(
                                    'لیست بایگانی خالی است. می تونید یکی از تست ها را انتخاب کنید و پس از انجام تست و ذخیره کردن، در این قسمت بررسی کنید',
                                    strutStyle: StrutStyle(height: 1.5),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),
                          ),


                    );
                  } else if (state is QuizErrorState) {
                    return Center(
                      child: Text('مشکل در دریافت اطلاعات'),
                    );
                  } else if (state is QuizListLoadedState) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("لیست تست های انجام شده"),
                        backgroundColor: Color.fromRGBO(138, 35, 135, 1.0),
                      ),
                      body: ListView.builder(
                          itemCount: state.quizListModel.length,
                          itemBuilder: (_, int index) {
                            return Card(
                              child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(state.quizListModel[index].name),
                                  trailing: Icon(Icons.chevron_right),
                                  leading: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _showDialog(state.quizListModel[index]);
                                      }),
                                  onTap: () {
                                    var db = new DatabaseHelper();
                                    Repository repository =
                                        new Repository(database: db);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                  create: (context) => QuizBloc(
                                                      repository: repository),
                                                  child: ShowQuizItems(
                                                    quizListModel: state
                                                        .quizListModel[index],
                                                  ),
                                                )));
                                  }),
                            );
                          }),
                    );
                  }
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        )),
      ),
    );
  }

  _showDialog(QuizListModel quizListModel) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(top: 10.0),
            elevation: 10,
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      "${quizListModel.name} حذف شود؟",
                      style: new TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontFamily: 'IRANYekanMobileMedium'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    child: Text(
                      "با این انتخاب  ${quizListModel.name} از لیست شما حذف می شود",
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black45,
                          fontFamily: 'IRANYekanMobileMedium'),
                      strutStyle: StrutStyle(height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(138, 35, 135, 1.0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: Text(
                          "حذف شود",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () async {
                        _submit(quizListModel);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _submit(QuizListModel quizListModel) async {
    var db = new DatabaseHelper();
    Repository repository = new Repository(database: db);
    var quizId = await repository.deleteQuiz(quizListModel);
    // sehdule the notification
    // manager.showNotificationDaily(medicineId, _name, _dose, hour, minute);
    // The medicine Id and Notitfaciton Id are the same
    quizId != null ? print('آی دی تست حذف شد') : print('آی دی تست حذف نشد');
    _updateData();
    Navigator.pop(context);
  }
}

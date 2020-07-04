import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptesting/bloc/quiz_bloc.dart';
import 'package:ptesting/bloc/quiz_event.dart';
import 'package:ptesting/bloc/quiz_state.dart';
import 'package:ptesting/model/QuizListModel.dart';
import 'package:ptesting/repository/database_helper.dart';
import 'package:ptesting/repository/repository.dart';
import 'package:ptesting/utils/data.dart';

class ShowQuizItems extends StatefulWidget {
  final QuizListModel quizListModel;
  ShowQuizItems({this.quizListModel});

  @override
  _ShowQuizItems createState() => _ShowQuizItems();
}

class _ShowQuizItems extends State<ShowQuizItems> {
  Future<void> _updateData() async {
    setState(() {
      BlocProvider.of<QuizBloc>(context).add(GetQuizEvent(quizId: widget.quizListModel.id));
    });
  }

  void callback() {
    setState(() {
      BlocProvider.of<QuizBloc>(context).add(GetQuizEvent(quizId: widget.quizListModel.id));
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
                      child: BlocBuilder<QuizBloc, QuizState>(
                          builder: (context, state) {
                            if (state is QuizInitioalState) {
                              BlocProvider.of<QuizBloc>(context)
                                  .add(GetQuizEvent(quizId: widget.quizListModel.id));
                            } else if (state is QuizEmptyState) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 30,),
                                      Text('لیست یادم باشه خالیست',
                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600, fontSize: 20),),
                                      Image.asset("assets/img/empty.png", height: 150,),
                                      ListTile(
                                        title: Text("توضیح:"),
                                        subtitle: Text(
                                          'در قسمت نام دارو اسم دارو خود را وارد کنید سپس در قسمت توضیحات تمامی توضیحات مربوط به دارو را نوشته و  در قسمت مدت یادآوری مشخص کنید که اپلیکیشن هر چند ساعت یاد آوری کند به عنوان مثال اگه دارو باید هر ۸ ساعت یک بار مصرف کنید مدت یاد آوری رو به روی ۸  تنظیم کنید. و در آخر ساعت شروع دارو که همان ساعت که دارو رو برای اولین بار مصرف کردید رو مشخص کنید',
                                          strutStyle: StrutStyle(height: 1.5),
                                        ),
                                      ),
                                      SizedBox(height: 100,)
                                    ],
                                  ),
                                ),

                              );
                            } else if (state is QuizErrorState) {
                              return Center(
                                child: Text('مشکل در دریافت اطلاعات'),
                              );
                            } else if (state is QuizLoadedState) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: Text(widget.quizListModel.name),
                                  backgroundColor: Color.fromRGBO(
                                      138, 35, 135, 1.0),
                                ),
                                body: ListView.builder(
                                    itemCount: state.quizModels.length,
                                    itemBuilder: (_, int index){
                                      return Card(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(5),
                                          title: Text(state.quizModels[index].title),
                                          subtitle: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    testList[state.quizModels[index].test],
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18
                                                  ),
                                                ),
                                                Text(
                                                  state.quizModels[index].code.toString(),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 18
                                                  ),

                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                )
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

}

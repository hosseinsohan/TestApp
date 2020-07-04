import 'package:flutter/material.dart';
import 'package:ptesting/model/QuizModel.dart';
import 'package:ptesting/utils/data.dart';
import 'package:ptesting/widgets/quize_widget.dart';

class QuizPage extends StatefulWidget {
  final int strongIndex;
  final String testName;

  QuizPage({this.strongIndex, this.testName});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<QuizModel> strongTest1 ;
  List<QuizModel> strongTest2 ;
  List<QuizModel> strongTest3 ;
  List<QuizModel> strongTest4 ;
  List<QuizModel> strongTest5 ;
  List<QuizModel> strongTest6 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    strongTest1 = new List<QuizModel>();
    strongTest2 = new List<QuizModel>();
    strongTest3 = new List<QuizModel>();
    strongTest4 = new List<QuizModel>();
    strongTest5 = new List<QuizModel>();
    strongTest6 = new List<QuizModel>();
    switch (widget.strongIndex) {
      case 0:
        for (int i = 0; i < strongTitle1.length; i++) {
          strongTest1.add(new QuizModel(
              title: strongTitle1[i],
              strongId: 1
          ));
        }
        break;
      case 1:
        for (int i = 0; i < strongTitle2.length; i++) {
          strongTest2.add(new QuizModel(
              title: strongTitle2[i],
              strongId: 2
          ));
        }
        break;
      case 2:
        for (int i = 0; i < strongTitle3.length; i++) {
          strongTest3.add(new QuizModel(
              title: strongTitle3[i],
              strongId: 3
          ));
        }
        break;
      case 3:
        for (int i = 0; i < strongTitle4.length; i++) {
          strongTest4.add(new QuizModel(
              title: strongTitle4[i], strongId: 4
          ));
        }
        break;
      case 4:
        for (int i = 0; i < strongTitle5.length; i++) {
          strongTest5.add(new QuizModel(
              title: strongTitle5[i],
              strongId: 5
          ));
        }
        break;
      case 5:
        for (int i = 0; i < strongTitle6.length; i++) {
          strongTest6.add(new QuizModel(
              title: strongTitle6[i],
              strongId: 6
          ));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(138, 35, 135, 1.0),
                Color.fromRGBO(233, 64, 87, 1.0),
                Color.fromRGBO(242, 113, 33, 1.0),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 56,
              ),
              QuizScreen(
                testName: widget.testName,
                quizModels: widget.strongIndex == 0
                    ? strongTest1
                    : widget.strongIndex == 1
                        ? strongTest2
                        : widget.strongIndex == 2
                            ? strongTest3
                            : widget.strongIndex == 3
                                ? strongTest4
                                : widget.strongIndex == 4
                                    ? strongTest5
                                    : strongTest6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

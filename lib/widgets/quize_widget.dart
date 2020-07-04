import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ptesting/model/QuizListModel.dart';
import 'package:ptesting/model/QuizModel.dart';
import 'package:ptesting/repository/database_helper.dart';
import 'package:ptesting/repository/repository.dart';
import 'package:ptesting/widgets/test_item_widget.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizModel> quizModels;
  final String testName;

  QuizScreen({this.quizModels, this.testName});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedIndex;
  int pageIndex;
  bool showEndButton = false;

  void callback(int index, int quizIndex) {
    setState(() {
      this.selectedIndex = index;
      widget.quizModels[quizIndex].test = index;
      widget.quizModels[quizIndex].code = 5 - index;
    });
  }

  @override
  void initState() {
    pageIndex = 0;
    print(widget.testName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final slider = CarouselSlider.builder(
      initialPage: 0,
      viewportFraction: 1.0,
      enableInfiniteScroll: false,
      scrollPhysics: NeverScrollableScrollPhysics(),
      itemCount: widget.quizModels.length + 1,
      height: MediaQuery.of(context).size.height - 56,
      onPageChanged: (index) {
        pageIndex = index;
        if(index == widget.quizModels.length) {
          setState(() {
            showEndButton = true;
          });
        }
        else{
          setState(() {
            showEndButton = false;
          });
        }
      },
      itemBuilder: (_, int index) {
        return SingleChildScrollView(
          child: index != widget.quizModels.length
              ? Center(
                  child: Container(
                      width: 300,
                      height: 450,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 300,
                            height: 100,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: Text(
                              '${widget.quizModels[index].title}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          SuggestionSelect(
                              this.callback, index, widget.quizModels[index])
                        ],
                      )),
                )
              : Container(
             width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
                  child: Container(


                      child: ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            ),
                        child: RaisedButton(
                          child: Text("ذخیره", style: TextStyle(color: Colors.white),),
                          onPressed: ()  {
                            _showDialog(widget.testName);
                          },
                        ),
                      ),
                    ),
                ),
        );
      },
      /*items: widget.test.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return
          },
        );
      }).toList(),*/
    );
    return Stack(
      children: <Widget>[
        Center(child: slider),

        Padding(
          padding: const EdgeInsets.only(top: 100),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                )),
                child: RaisedButton(
                  color: Color.fromRGBO(233, 64, 87, 1.0).withOpacity(0.4),
                  onPressed: () => slider.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear),
                  child: Text(
                    'قبلی',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
                showEndButton?
                    Container()
            :Flexible(
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
                child: RaisedButton(
                  color: Color.fromRGBO(233, 64, 87, 1.0).withOpacity(0.4),
                  onPressed: () => widget.quizModels[pageIndex].test != null
                      ? slider.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear)
                      : getAlert(context),
                  child: Text(
                    'بعدی',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        )
      ],
    );
  }

  _showDialog(String _testName) {
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
                      "اضافه به بایگانی",
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
                      "با این انتخاب این تست به لیست بایگانی شما اضافه می شود ",
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
                          color: Color.fromRGBO(233, 64, 87, 1.0),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: Text(
                          "ذخیره",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        _submit(_testName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _submit(String _testName) async {
    var db = new DatabaseHelper();
    Repository repository = new Repository(database: db);
    var quizId =
        await repository.insertQuiz(QuizListModel(name: _testName));
    print('sssssssssssss + ${widget.testName}');
    // sehdule the notification
    // manager.showNotificationDaily(medicineId, _name, _dose, hour, minute);
    // The medicine Id and Notitfaciton Id are the same
    print('آی دی تست ذخیره شده' + quizId.toString());

    _saveData(quizId)..forEach((int i) => print("ایتم با آی دی $i ثبت شد"));

    Navigator.pop(context);
    Navigator.pop(context);
  }

  Stream<int> _saveData(int quizId) async* {
    var db = new DatabaseHelper();
    Repository repository = new Repository(database: db);
    for (int i = 0; i < widget.quizModels.length; i++) {
      widget.quizModels[i].quizId = quizId;
      var id = await repository.insertQuizItem(widget.quizModels[i]);

      //print(' این ایتم اضافه شد${widget.quizModels[i].title}');
      yield id;
    }
  }
}

getAlert(BuildContext context, ) {
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
                    "تست بدون پاسخ می باشد!!!",
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
                    "لطفا یکی از گزینه را انتخاب کنید",
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
                        color: Color.fromRGBO(233, 64, 87, 1.0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Text(
                        "باشه",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

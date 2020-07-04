import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptesting/page/about_me.dart';
import 'package:ptesting/page/quiz_list_page.dart';
import 'package:ptesting/page/quiz_page.dart';
import 'package:ptesting/page/show_quiz_items.dart';
import 'package:ptesting/page/show_quiz_test.dart';
import 'package:ptesting/repository/database_helper.dart';
import 'package:ptesting/repository/repository.dart';

import 'bloc/quiz_bloc.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'IRANYekanMobileMedium',
      ),
      home: MyHomePage(),
    );
  }



}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<int> fetchAlbum() async{
  return 1;
}
class _MyHomePageState extends State<MyHomePage> {

  TextEditingController nameController ;


  Future<int> futureAlbum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = fetchAlbum();
    nameController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var page = MediaQuery.of(context).size;
    return FutureBuilder<int>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data==1){
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: Container(
                    width: page.width,
                    height: page.height,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          width: page.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(138, 35, 135, 1.0),
                                    Color.fromRGBO(233, 64, 87, 1.0),
                                    Color.fromRGBO(242, 113, 33, 1.0),
                                  ])),
                        ),
                        Positioned(
                          top: 40,
                          left: 20,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.push(context, MaterialPageRoute(
                                    builder: (_) =>AboutMe()
                                )),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 113, 33, 1.0),
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(138, 35, 135, 1.0),
                                      offset: new Offset(8.0, 10.0),
                                      blurRadius: 25.0),
                                ]),
                          ),
                          /**/
                        ),
                        Positioned(
                          top: 40,
                          right: 20,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    //Navigator.push(context, MaterialPageRoute(builder: (_) => ShowQuizItems())),
                                    var db = new DatabaseHelper();
                                    Repository repository = new Repository(database: db);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                create: (context) =>
                                                    QuizBloc(repository: repository),
                                                child: ShowQuizTest())));
                                  }),
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 113, 33, 1.0),
                                borderRadius: BorderRadius.circular(35),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(138, 35, 135, 1.0),
                                      offset: new Offset(8.0, 10.0),
                                      blurRadius: 25.0),
                                ]),
                          ),
                          /**/
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 100),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  "پرسشنامه رغبت استرانگ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: page.width > 1000?640
                                      :page.width > 600?480
                                      :320,
                                  child: GridView.builder(
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: page.width > 1000
                                              ? 4
                                              : page.width > 600 ? 3 : 2,
                                          childAspectRatio: 100 / 120
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 6,
                                      itemBuilder: (_, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            _showDialog(index);

                                          },
                                          child: Container(
                                            width: 100,
                                            height: 120,
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                RichText(
                                                  text: new TextSpan(
                                                    style: new TextStyle(
                                                        fontSize: 16.0,
                                                        fontFamily:
                                                        'IRANYekanMobileMedium',
                                                        color: Colors.black),
                                                    children: <TextSpan>[
                                                      new TextSpan(
                                                        text:
                                                        "آزمون رغبت سنچ شغلی استرانگ قسمت ",
                                                      ),
                                                      new TextSpan(
                                                          text: index == 0
                                                              ? "اول"
                                                              : index == 1
                                                              ? "دوم"
                                                              : index == 2
                                                              ? "سوم"
                                                              : index == 3
                                                              ? "چهارم"
                                                              : index == 4
                                                              ? "پنجم"
                                                              : "ششم",
                                                          style: TextStyle(
                                                            color: Colors.redAccent,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Wrap(
                                                  spacing: 20,
                                                  runSpacing: 10,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.black45),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.black45),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.green),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.black45),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 56,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          }
        } else if (snapshot.hasError) {
          Text("لطفا به اینترنت متصل شوید و دوباره وارد شوید");
        }

        // By default, show a loading spinner.
        return Scaffold(body: Container(
            width: page.width,
            height: page.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(138, 35, 135, 1.0),
                      Color.fromRGBO(233, 64, 87, 1.0),
                      Color.fromRGBO(242, 113, 33, 1.0),
                    ])),
            child: Center(child: CircularProgressIndicator())));
      },
    );





  }

  _showDialog(int index) {
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
                      "لطقا یک نام برای تست انتخاب کنید",
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                          controller: nameController,

                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: const OutlineInputBorder(),
                            labelStyle: new TextStyle(color: Colors.green),
                            hintText: "نام تست ..."
                        ),
                      ),
                    )
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
                          "شروع تست",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () async {
                        if(nameController.text!=""){
                          print(nameController.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      new QuizPage(
                                        strongIndex: index,
                                        testName: nameController.text
                                      )));

                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

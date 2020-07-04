import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
          title: Text("لیست تست های انجام شده"),
      backgroundColor: Color.fromRGBO(138, 35, 135, 1.0),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListTile(
            title: Text("پرسشنامه رغبت سنج استرانگ به شما در فهم رغبت هاي شغلي تان کمک نموده  و انواع مشاغلي که احتمالاً در آنها احساس راحتي مي کنيد را به شما نشان مي دهد. در این اپلیکیشن مشاغل، فعاليت ها، زمينه هاي موضوعي و ... فهرست بندي شده است که شما بايد ميزان علاقمندي، يا عدم علاقمندي خود را در قبال آن مشخص سازيد. استرانگ آزمون توانمندي نيست بلکه پرسشنامه اي در خصوص رغبت هاي شماست.لطفاً به همه پرسش ها پاسخ دهيد. وقت زيادي را به فکر کردن در مورد آنها اختصاص ندهيد و اولين چيزي که به ذهنتان مي رسد را منظور نماييد.",
            style: TextStyle(fontSize: 18), strutStyle: StrutStyle(height: 2),),
          )
        ),
      )
      ),
    );
  }
}

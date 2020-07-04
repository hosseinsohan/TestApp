import 'package:flutter/material.dart';
import 'package:ptesting/model/QuizModel.dart';

class SuggestionSelect extends StatefulWidget {
  final Function callback;
  final int quizIndex;
  final QuizModel quizModel;

  SuggestionSelect(this.callback, this.quizIndex, this.quizModel);
  @override
  _SuggestionSelectState createState() => _SuggestionSelectState();
}

class _SuggestionSelectState extends State<SuggestionSelect> {
  int select ;

  @override
  void initState() {
    super.initState();

    widget.quizModel.test==null?select = 10000: select = widget.quizModel.test;
  }

  @override
  Widget build(BuildContext context) {
    var page = MediaQuery.of(context).size;
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: ContainerAnimation(
                index: index,
                select: select,
              ),
              onTap: () {
                setState(() {
                  select = index;
                  this.widget.callback(index, widget.quizIndex);

                });
              },
            );
          }),
    );
  }
}

//container statefullwidget for shahing

class ContainerAnimation extends StatefulWidget {
  final int index;
  final int select;

  ContainerAnimation({this.index, this.select});

  @override
  _ContainerAnimationState createState() => _ContainerAnimationState();
}

class _ContainerAnimationState extends State<ContainerAnimation> {
  var margin;
  int flage = 0;

  @override
  void initState() {
    margin = EdgeInsets.symmetric(horizontal: 30, vertical: 5);
    super.initState();
  }

  move() {
    setState(() {
      margin = EdgeInsets.only(left: 40, right: 20, top: 5, bottom: 5);
    });
  }

  back() {
    setState(() {
      margin = EdgeInsets.symmetric(horizontal: 30, vertical: 5);
    });
  }

  animation() {
    Future.delayed(Duration(milliseconds: 250), () {
      return move();
    });
    Future.delayed(Duration(milliseconds: 500), () {
      return back();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("select: ${widget.select} index: ${widget.index}");
    var page = MediaQuery.of(context).size;

    if (widget.index == widget.select && flage == 0) {
      animation();
      flage = 1;
    } else if (widget.index != widget.select && flage == 1) {
      flage = 0;
    }
    return AnimatedContainer(
      //width: page.width - 80,
      margin: margin,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.select == widget.index ? Colors.green : Colors.white,
        border: Border.all(
            color: widget.select == widget.index ? Colors.green : Colors.grey,
            width: 1.0),
        //color: index % 2 == 0 ? Colors.yellow : Colors.green
      ),
      duration: Duration(milliseconds: 10),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              widget.index == 0
                  ? "بسيارعلاقمندم"
                  : widget.index == 1
                      ? "علاقه مندم"
                      : widget.index == 2
                          ? "علاقه مندم"
                          : widget.index == 3
                              ? "علاقه مند نيستم"
                              : "اصلاً علاقه مند نيستم",
              style: TextStyle(
                color:
                    widget.select == widget.index ? Colors.white : Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
          Icon(
            Icons.check,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }
}

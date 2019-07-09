import 'package:flutter/material.dart';

import 'package:country_quiz/fix_pub_lib/flutter_spinkit_3.1.0_fix/wave.dart';


class CountDown extends AnimatedWidget {
  CountDown({Key key, this.color, this.animation}) : super(key: key, listenable: animation);

  final Color color;
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    return Text(
      animation.value.toString(),
      style: TextStyle(
        color: color,
        fontSize:  MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }
}

class CountDownPage extends StatefulWidget {
  // トップページに関するウィジェット

  CountDownPage({Key key, this.widget, this.backgroundColor, this.barColor, this.charColor}) : super(key: key);

  final dynamic widget;
  final Color backgroundColor;
  final Color barColor;
  final Color charColor;


  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage>  with TickerProviderStateMixin {

  _CountDownPageState();

  AnimationController _controller;

  static const int counter = 4;

  void _navigateToConverter(BuildContext context, Widget widget) { // 画面遷移に関するウィジェット(ナビゲーターで管理)
    Navigator.of(context).push(MaterialPageRoute( // CountryListウィジェットに、画面を遷移させる
      builder: (BuildContext context) {
        return widget;
      },
    ));
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: counter),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Stack(
  //          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitWave(
                color: widget.barColor,
                size: MediaQuery.of(context).size.width -  MediaQuery.of(context).size.width / 15,
                duration: Duration(milliseconds: 1000),
              ),
              Center(
                child: CountDown(
                  color: widget.charColor,
                  animation: StepTween(
                    begin: counter,
                    end: 0,
                  ).animate(_controller)
                  ..addStatusListener((state) => _navigateToConverter(context, widget.widget)),
                ),
              ),
            ],
            fit: StackFit.expand,
          ),
        ),
      ),
    );
  }
}
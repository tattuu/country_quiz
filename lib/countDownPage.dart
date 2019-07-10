import 'package:flutter/material.dart';

import 'package:country_quiz/fix_pub_lib/flutter_spinkit_3.1.0_fix/wave.dart';


class CountDown extends AnimatedWidget { // カウントダウンに関するクラス
  CountDown({Key key, this.color, this.animation}) : super(key: key, listenable: animation);

  final Color color; // 文字の色
  final Animation<int> animation; // アニメーションに関する変数

  @override
  build(BuildContext context) {
    return Text( // アニメーションしているカウントダウン数字としてのテキスト
      animation.value.toString(), // アニメーションされるテキスト(表示されるのは、整数部分)
      style: TextStyle(
        color: color,
        fontSize:  MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }
}

class CountDownPage extends StatefulWidget { // カウントダウンページに関するクラス

  CountDownPage({Key key, this.widget, this.barColor}) : super(key: key);

  final dynamic widget; //
  final Color barColor;


  @override
  _CountDownPageState createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage>  with TickerProviderStateMixin {

//  _CountDownPageState();

  AnimationController _controller; // アニメーションに関するコントローラ

  static const int counter = 4; // カウント数字の開始時間

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

    _controller = AnimationController( // アニメーションの開始時間を設定
      vsync: this,
      duration: Duration(seconds: counter),
    );
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Stack(
  //          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitWave( // 波を表示するためのウィジェットに関するクラス
                color: widget.barColor,
                size: MediaQuery.of(context).size.width -  MediaQuery.of(context).size.width / 15, // 波の横幅
                duration: Duration(milliseconds: 1000), // 波が元の形に戻るまでの時間を指定
              ),
              Center(
                child: CountDown( // カウントダウン数字を表示する
                  color: Colors.orange,
                  animation: StepTween(
                    begin: counter,
                    end: 0,
                  ).animate(_controller)
                  ..addStatusListener((state) => _navigateToConverter(context, widget.widget)),  // カウントダウンページ終了後に遷移するページを指定
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
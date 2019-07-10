import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:country_quiz/challengeResult.dart';
import 'package:country_quiz/finPage.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';

class TestPage extends StatefulWidget { // テストページに関するステートフルなクラス

  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  final _questionCount = 15; // 質問数
  final List<Country> _knowList = []; // 正解した国を格納するリスト
  final List<Country> _unKnowList = []; // 不正解した国を格納するリスト
  final List<Country> _questionList = []; // 問題&選択肢として使われる国オブジェクトが入るリスト
  int _counter; // 現在の問題数
  double _percent; // 全問題数に対する現在までに説いている問題数の割合
  double _finOpacity = 1.0; // 勝った後に表示するページの透過度
  double _selectButton1Shape = 30;
  double selectButtonTextSize = 20; // Page1のボタン内に表示されるテキストサイズが入る変数
  double questionViewPadding = 20; // 問題表示カードのPadding指定
  double selectButton1FieldHeightSize; // ボタンサイズ
  double selectButton2FieldHeightSize; // ボタンサイズ
  bool _questionFormat = true; // 問題形式を決定する変数
  Country _questionViewCountry; // 問題として利用される国が入る変数
  dynamic _questionViewContent; // 問題表示カードに表示されるコンテンツが表示される変数
  var random; // 出題する問題のランダム性を高めるために利用する乱数のための変数

  void _getQuestionCountry() { // 1問に使う国オブジェクトを取得するメソッド
    setState(() {
      _questionList.clear(); // 1問に使う国のリストを初期化
      _questionFormat = random.nextInt(2) == 0 ? true : false; // どちらの形式で問題を出力するか決める(0がPage1, 1がPage2)

      for (int i = 0; i < 4; i++) { // 選択肢取得数分だけ回す
        while(i == _questionList.length) { // これまでに答えとなった国を含め、ユニークな選択肢(国)が得られるまで回す
          var keep = countryList(context)[random.nextInt(countryList(context).length)]; // 仮の選択肢

          var combineCheck = false; // 同じ国が存在するかどうか
          _knowList.forEach((country) { // これまでに正解した国の中に、keepの国があるかどうか
            if (country.isoCode == keep.isoCode) {
              combineCheck = true;
            }
          });
          _unKnowList.forEach((country) { // これまでに不正解した国の中に、keepの国があるかどうか
            if (country.isoCode == keep.isoCode) {
              combineCheck = true;
            }
          });
          _questionList.forEach((_oneQuestion) { // 現在抽出した選択肢の中に、同じやつがあるかどうか
            if (_oneQuestion.isoCode == keep.isoCode) {
              combineCheck = true;
            }
          });
          if (!combineCheck) { // ユニークだった場合、選択肢として追加する
            _questionList.add(keep);
          }
        }
      }

      _questionViewCountry = _questionList[random.nextInt(_questionList.length)]; // 選択肢の中から、問題(答え)となる国を選ぶ
      if (!_questionFormat) { // Page1を選ぶ
        _questionViewContent = Image.asset(CountryPickerUtils.getFlagImageAssetPath(_questionViewCountry.isoCode)); // 国旗(画像)ウィジェットを取得する
      } else { // Page2を選ぶ
        _questionViewContent = Center( // 国名に関するウィジェット
          child: Text(
            _questionViewCountry.name,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    _counter = 0;
    _percent = 0.0;
    random = Random.secure();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getQuestionCountry(); // 1問目を取得
  }

  void _screenTransition() { // テスト完了ページ表示&結果ページ遷移メソッド(15問終了した場合に呼び出される処理)
    Timer(Duration(milliseconds: 3100), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => // 結果ページへ遷移
          ChallengeResult(
            knowCountryList: _knowList,
            unKnowCountryList: _unKnowList,
          ),
      ));
    });
    Timer(Duration(milliseconds: 800), () { // テスト本体部分を透明にし、テスト完了ページを表示する
      setState(() {
        _finOpacity = 0.0;
      });
    });
  }

  void _tapCheck(Country country) { // 選択肢がタップされた場合に呼ばれるメソッド
    if (_counter < _questionCount) { // 15問解いていない場合
      var uniqueCheck = true; // 高速連続タップ時に、同じ国が追加される問題を解消(問いとして抽出される国は、ユニークであるため、このチェックは、連続タップ時の同国追加問題解消のみを対象としている)
      _knowList.forEach((country) {
        if (_questionViewCountry.isoCode == country.isoCode) { // 連続タップされた国が、knowListに入っていた場合
          uniqueCheck = false;
        }
      });
      _unKnowList.forEach((country) {
        if (_questionViewCountry.isoCode == country.isoCode) {  // 連続タップされた国が、unKnowListに入っていた場合
          uniqueCheck = false;
        }
      });

      if(uniqueCheck) { // 連続タップされていない場合
        _counter++; // 回答数をインクリメント
        _percent = _counter.toDouble() / _questionCount; // 割合計算
        if (_questionViewCountry.isoCode == country.isoCode) { // 問題として表示されている国と同じ国をタップした場合
          _knowList.add(_questionViewCountry); // 知っている国をknowListに追加
        } else {  // 問題として表示されている国と違う国をタップした場合
          _unKnowList.add(_questionViewCountry); // 知っていない国をunKnowListに追加
        }
        if (_counter == _questionCount) { // 15問解いた場合
          _screenTransition();
        }
        if (_counter < _questionCount) { // 解いた問題数が15問未満の場合
          _getQuestionCountry(); // 新しい問題を取得
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    if (MediaQuery.of(context).size.width < 480) { // スマホ対応
      _selectButton1Shape = 30;
      selectButtonTextSize = 20;
      questionViewPadding = 20;
      selectButton1FieldHeightSize = MediaQuery.of(context).size.height / 11.85;
      selectButton2FieldHeightSize = MediaQuery.of(context).size.height / 5.121;
    } else if (MediaQuery.of(context).size.width < 960) { // タブレット対応
      _selectButton1Shape = 60;
      selectButtonTextSize = 30;
      questionViewPadding = 40;
      selectButton1FieldHeightSize = MediaQuery.of(context).size.height / 10.5;
      selectButton2FieldHeightSize = MediaQuery.of(context).size.height / 4.83;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
          ..pop()..pop();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Opacity(
                opacity: _finOpacity == 1.0 ? 0.0 : 1.0, // テスト完了ページは、winOpacityが0.0の時にのみ表示する
                child: FinPage(knowListCount: _knowList.length, questionCount: _questionCount), // テスト完了ページに関するメソッド
              ),
              Opacity(
                opacity: _finOpacity, // テスト本体ページの透過度(1.0の時に表示)
                child: _basePage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progressBar(BuildContext context) { // 進捗バーのウィジェット
    return  Container(
      width: MediaQuery.of(context).size.width - 5,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10),

      child:Container(
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [ // 影を付ける
            new BoxShadow(
              color: Colors.grey,
              offset: new Offset(2, 6.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: LinearPercentIndicator( // 線形割合進捗バーの本体
//        width: MediaQuery.of(context).size.width - 20,
          lineHeight: 20.0,
          percent: _percent,
          progressColor: Colors.greenAccent, // 割合によって塗りつぶされていくバーの色
          backgroundColor: Colors.blueAccent, // 背景色のバーの色
        ),
      ),
    );
  }

  Widget _questionView(BuildContext context) { // 問題表示カードに関するウィジェット
    return  Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(questionViewPadding),
//      color: Colors.orange,
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        child: Container(
          padding: EdgeInsets.all(10),
          child: _questionViewContent, // 国名or国旗が表示される
        ),
      ),
    );
  }

  Widget _selectButtonBase1(BuildContext context, Country country) { // Page1で使われる、選択肢ボタンのウィジェット(国名が表示される)
    return Container(
      padding: EdgeInsets.only(top: 8, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tapCheck(country); // 選択肢がタップされた場合に行われる処理を実行
          });
        },
        child: Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_selectButton1Shape),
          ),
          elevation: 7,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.05,
            height: selectButton1FieldHeightSize,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Text( // 国名表示
                country.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: selectButtonTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectButtonBase2(BuildContext context, Country country) { // Page2で使われる、選択肢ボタンのウィジェット(国旗が表示される)
    return Container(
      padding: EdgeInsets.only(top: 8, left: 2, right: 2),
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tapCheck(country);
          });
        },
        child: Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
          child: Container(
            height: selectButton2FieldHeightSize,
            width: MediaQuery
                .of(context)
                .size
                .width / 2.3,
            padding: EdgeInsets.all(5),
            child: Image.asset(CountryPickerUtils.getFlagImageAssetPath(country.isoCode)), // 国旗を表示
          ),
        ),
      ),
    );
  }

  Widget _battlePage1(BuildContext context) { // 国旗を問題、国名を選択肢とする形式のウィジェット
    return Column(
      children: <Widget>[
        _selectButtonBase1(context, _questionList[0]),
        _selectButtonBase1(context, _questionList[1]),
        _selectButtonBase1(context, _questionList[2]),
        _selectButtonBase1(context, _questionList[3]),
      ],
    );
  }

  Widget _battlePage2(BuildContext context) { // 国名を問題、国旗を選択肢とする形式のウィジェット
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _selectButtonBase2(context, _questionList[0]),
            _selectButtonBase2(context, _questionList[1]),
          ],
        ),
        Row(
          children: <Widget>[
            _selectButtonBase2(context, _questionList[2]),
            _selectButtonBase2(context, _questionList[3]),
          ],
        ),
      ],
    );
  }

  Widget _basePage(BuildContext context) { // 選択肢部分のベースウィジェット
    return Column(
      children: <Widget>[
        _progressBar(context),
        _questionView(context),
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          child: _questionFormat == true ?  _battlePage2(context) : _battlePage1(context), // _questionFormatによって、表示形式を変更する
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/flutter_tindercard_0.105_fix/flutter_tindercard.dart';
import 'package:country_quiz/challengeResult.dart';

class TrainingPage extends StatefulWidget { // Trainingページに関するステートフルなクラス

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> with TickerProviderStateMixin {

  List<Country> _countryList = []; // 
  List<Image> _countryImageWidgetList = []; //

  List<Country> _knowList = []; // 知っている国として分類された国を追加するためのリスト
  List<Country> _unKnowList = []; // 知っていない国として分類された国を追加するためのリスト
  int _counter = 1; // 現在スライドしようとしている国の数のカウンター
  
  @override
  void initState() { // 初期化メソッド
    super.initState();
  }

  @override
  void didChangeDependencies() { // initState()メソッドの後に実行されるメソッド
    super.didChangeDependencies();
    _countryList = countryList(context).where(acceptAllCountries).toList(); // countries.dartに入っている全部の国のリストを代入

    _countryList.forEach((country) { // 各国の画像データを_countryImageWidgetListに追加
      _countryImageWidgetList.add( // 画像ウィジェットを追加
        Image.asset( // 画像ウィジェットを生成
          CountryPickerUtils.getFlagImageAssetPath(country.isoCode) // 画像イメージパスを呼び出す
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope( // 端末の戻るボタンを押した場合の処理
      onWillPop: () { // challengeページに移動する
        Navigator.of(context)
            ..pop()
            ..pop();
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
    //          mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack( // Stackの形にして、Tinderカードを最前面にし、他のウィジェットと重なった時に、それ以外のウィジェットより上にカードを表示するようにする
                  children: <Widget>[
                    Container( // 現在までの表示国数の割合
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.17),
                      child: Text(
                        '$_counter' + '/' + _countryList.length.toString(), // 割合表示の本体
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container( // Tinderカードに関するウィジェット
                      height: MediaQuery.of(context).size.height * 0.78,
                      child: TinderSwapCard(
                        orientation: AmassOrientation.TOP,
                        totalNum: _countryList.length, // 全カード枚数
                        stackNum: 5, // 重ねて表示するカード枚数
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.width * 0.9,
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        minHeight: MediaQuery.of(context).size.width * 0.8,
                        countryImageWidgets: _countryImageWidgetList, // Tinderカード化する要素の中の画像が入ったリスト
                        countryNames: _countryList, // Tinderカード化する要素の中の名前が入ったリスト
                        cardBuilder: (context, index) => _insideCard(index), // _insideCardメソッドで作成したTinderカードで表示する要素をBuilderに随時渡していく。
                        swipeCompleteCallback: (CardSwipeOrientation orientation, int index){ // スワイプの状態をコールバックする

                          if(orientation==CardSwipeOrientation.RIGHT) { // スワイプが右に動かされて終了した場合
                            _knowList.add(_countryList[index]); // 知っている国として、現在カードに表示されている国を、knowリストに追加
                          } else if(orientation==CardSwipeOrientation.LEFT) { // スワイプが左に動かされて終了した場合
                            _unKnowList.add(_countryList[index]); // 知っていない国として、現在カードに表示されている国を、unKnowリストに追加
                          }

                          if (index + 1 == _countryList.length) { // 最後のカードがスライドされた場合
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => // カードが全部スライドし終わった後、結果表示ページに遷移する
                                ChallengeResult( // 結果表示ページに関するウィジェット
                                  knowCountryList: _knowList,
                                  unKnowCountryList: _unKnowList,
                                ),
                            ));
                          }

                          if(orientation==CardSwipeOrientation.RIGHT || orientation==CardSwipeOrientation.LEFT) { // 右か左にスワイプし終わった場合
                            setState(() { // 以下の値の状態を非同期で変える
                              _counter++; // これまでに表示しいてる国のカウントをインクリメント
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _insideCard(int index) { // 表示させるカードを作成するメソッド(最前面以外の部分)
    return GestureDetector( // クリックイベントを実装するためのウィジェット
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height/ 3,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: _countryImageWidgetList[index],
            ),
//                Spacer(),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 2, left: MediaQuery.of(context).size.width / 10, right: MediaQuery.of(context).size.width / 10),
              child: Text(
                '',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
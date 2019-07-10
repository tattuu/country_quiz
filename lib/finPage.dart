import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FinPage extends StatelessWidget { // テスト完了ページ(テストページ終了後に表示されるページ)
  final int knowListCount; // 知っている国のオブジェクトが入ったリスト
  final questionCount; // クイズ数

  FinPage({this.knowListCount, this.questionCount}); // コンストラクタ

  String _resultFaceImagePath() { // 正解数に応じたフェイス画像を選んで返す
    switch (knowListCount) {
      case 0:
        {return 'assets/resultFace/0.png';}
        break;
      case 1:
        {return 'assets/resultFace/1.png';}
        break;
      case 2:
        {return 'assets/resultFace/2.png';}
        break;
      case 3:
        {return 'assets/resultFace/3.png';}
        break;
      case 4:
        {return 'assets/resultFace/4.png';}
        break;
      case 5:
        {return 'assets/resultFace/5.png';}
        break;
      case 6:
        {return 'assets/resultFace/6.png';}
        break;
      case 7:
        {return 'assets/resultFace/7.png';}
        break;
      case 8:
        {return 'assets/resultFace/8.png';}
        break;
      case 9:
        {return 'assets/resultFace/9.png';}
        break;
      case 10:
        {return 'assets/resultFace/10.png';}
        break;
      case 11:
        {return 'assets/resultFace/11.png';}
        break;
      case 12:
        {return 'assets/resultFace/12.png';}
        break;
      case 13:
        {return 'assets/resultFace/13.png';}
        break;
      case 14:
        {return 'assets/resultFace/14.png';}
        break;
      case 15:
        {return 'assets/resultFace/15.png';}
        break;
      default:
        {return 'assets/resultFace/7.png';}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Spacer(),
          Text( // 終わった事を示すための文字
            'Fin!',
            style: TextStyle(
              color: Colors.orange,
              fontSize: MediaQuery
                  .of(context)
                  .size
                  .width / 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 10,
          ),
          Image.asset( // フェイス画像表示
            _resultFaceImagePath(),
            height: MediaQuery
                .of(context)
                .size
                .width / 3,
            fit: BoxFit.fill,
          ),
          Container(
            height: 50,
          ),
          Container( // 正解数の割合を表示する
            alignment: Alignment.center,
            child: Text(
              '${knowListCount.toString()}/$questionCount',
              style: TextStyle(
                fontSize: MediaQuery
                    .of(context)
                    .size
                    .width / 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),

        ],
      ),
    );
  }
}
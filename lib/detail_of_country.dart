import 'package:flutter/material.dart';

class DetailOfCountry extends StatelessWidget { // create_one_country_columnクラスで作られた国のリスト内の、画像をクリックした時に表示されるページに関するクラス
  final String isoCode; // 詳細を表示したい国のisoCode
  final String flagImagePath; // 詳細を表示したい国の画像パス

  DetailOfCountry(this.isoCode, this.flagImagePath); // コンストラクタ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Center(
            child: Hero( // ヒーロータグを設定し、クリックしたある要素から、その要素を表示している別のウィジェットに遷移する時、滑らかに表示するためのウィジェット
              tag: isoCode, // タグをクリックした国旗の国に関するisoCordに設定
              child: Container(
                width: MediaQuery.of(context).size.width, // 表画像サイズ
                height: MediaQuery.of(context).size.height, // 表画像サイズ
                child: Image.asset(
                  flagImagePath,
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
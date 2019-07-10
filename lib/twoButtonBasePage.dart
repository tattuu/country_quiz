import 'package:flutter/material.dart';
import 'package:country_quiz/copyrightAttribution.dart';
import 'package:country_quiz/l10n/l10n.dart';

class TwoButtonBasePage extends StatelessWidget { // 二つのアイコンボタンを表示するページに関するクラス
  final String title; // ページタイトル
  final String firstButtonName; // 1つ目(上)のボタンの名前
  final String secondButtonName; // 2つ目(下)のボタンの名前
  final IconData firstIconData; // 1つ目(上)のボタンのアイコン
  final IconData secondIconData; // 2つ目(下)のボタンのアイコン
  final Widget firstWidget; // 1つ目のボタンを押した時に実行されるページのクラス
  final Widget secondWidget; // 2つ目のボタンを押した時に実行されるページのクラス
  final double firstFontSize; // 1つ目のボタンの名前
  final double secondFontSize; // 2つ目のボタンの名前
  final Color iconColor; // アイコンボタンの背景色

  TwoButtonBasePage({ // コンストラクタを用いて変数に値を設定
    this.title,
    this.firstButtonName,
    this.secondButtonName,
    this.firstIconData,
    this.secondIconData,
    this.firstWidget,
    this.secondWidget,
    this.firstFontSize,
    this.secondFontSize,
    this.iconColor,
  });

  void _navigateToConverter(BuildContext context, Widget widget) { // 画面遷移に関するメソッド(ナビゲーターで実行)
    Navigator.of(context).push(MaterialPageRoute( // 指定した画面関連ウィジェットに遷移する
      builder: (BuildContext context) {
        return widget;
      },
    ));
  }

  Widget _copyrightDisplay(BuildContext context) { // 著作権関係ページ表示に関するウィジェット
    if (title == L10n.of(context).challenge) { // もし表示するべきページであるなら、著作権関係ページ表示に関するウィジェットを表示する
      return Container(
        height: 40,
        width: 40,
        child: FloatingActionButton( // フローティングアクションボタンの形式で表示する
            backgroundColor: Colors.blue[600],
            child: Icon(
              Icons.layers,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => // 著作権関係表示ページに遷移する
                  CopyrightAttributionPage()));
            }
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _iconLogo(BuildContext context, IconData icon, Widget widget, double fontSize, Color iconColor, double iconSizeHeight, double iconSizeWidth) { // アイコンに関するウィジェット
    return ClipRRect( // 円形に関するウィジェット
      borderRadius: BorderRadius.circular(iconSizeWidth / 2), // 円形にする
      child: Container(
        height: iconSizeHeight, // アイコンのサイズ
        width: iconSizeWidth, // アイコンのサイズ
        color: iconColor,
        child: Center(
          child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            iconSize: fontSize,
            onPressed: () => _navigateToConverter(context, widget), // アイコンをクリックした場合の処理
          ),
        ),
      ),
    );
  }

  Widget _iconName(BuildContext context, String name, Widget widget, double textFontSize) { // アイコン下の文字に関するウィジェット
    return GestureDetector( // クリック処理を追加
      onTap: () => _navigateToConverter(context, widget), // 文字をクリックした時の処理
      child: Text( // 文字に関するウィジェット
        name,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: textFontSize, // フォントサイズ
          fontWeight: FontWeight.bold, // 太字
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double iconSizeHeight; // 1つ目のボタンのサイズ
    double iconSizeWidth; // 2つ目のボタンのサイズ
    double textFontSize; // 1つ目のボタンの名前のサイズ

    if (MediaQuery.of(context).size.width < 480) { // スマホ対応
      iconSizeHeight = 150;
      iconSizeWidth = 150;
      textFontSize = 40;
    } else if (MediaQuery.of(context).size.width < 960) { // タブレット対応
      iconSizeHeight = 300;
      iconSizeWidth = 300;
      textFontSize = 80;
    }

    return Scaffold( // 足場に関するウィジェット
      appBar: AppBar( // アップバーの設定
        iconTheme: IconThemeData(
          color: Colors.white, //chan
          // ge your color here
        ),// アップバーに関するウィジェット
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      floatingActionButton: _copyrightDisplay(context), // 著作権表示ページに関するフローティングアクションボタンについてのプロパティ
      body: SafeArea( // ステータスバーなどに関するsizeをsafeにするためのウィジェット
        child: Center(
          child: Column( // 縦の行を作成するウィジェット
            mainAxisAlignment: MainAxisAlignment.spaceAround, // 中央揃え
            children: <Widget>[
              Spacer(flex: 10), // Spacer()は、空白の比率
              _iconLogo(context, firstIconData, firstWidget, firstFontSize, iconColor, iconSizeHeight, iconSizeWidth), // 画像をアイコンとして生成して、iconLogoに渡す
              Spacer(),
              _iconName(context, firstButtonName, firstWidget, textFontSize), // アイコン下の文字に関する処理
              Spacer(flex: 15),
              _iconLogo(context, secondIconData, secondWidget, secondFontSize, iconColor, iconSizeHeight, iconSizeWidth),
              Spacer(),
              _iconName(context, secondButtonName, secondWidget, textFontSize),
              Spacer(flex: 10),
            ],
          ),
        ),
      ),
    );
  }
}
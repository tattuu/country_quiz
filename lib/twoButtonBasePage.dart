import 'package:flutter/material.dart';
import 'package:country_quiz/copyrightAttribution.dart';
import 'package:country_quiz/l10n/l10n.dart';

class TwoButtonBasePage extends StatelessWidget {
  final String title;
  final String firstButtonName;
  final String secondButtonName;
  final IconData firstIconData;
  final IconData secondIconData;
  final Widget firstWidget;
  final Widget secondWidget;
  final double firstFontSize;
  final double secondFontSize;
  final Color iconColor;

  double iconSizeHeight;
  double iconSizeWidth;
  double iconFontSize;
  double textFontSize;



  TwoButtonBasePage({
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

  void _navigateToConverter(BuildContext context, Widget widget) { // 画面遷移に関するウィジェット(ナビゲーターで管理)
    Navigator.of(context).push(MaterialPageRoute( // CountryListウィジェットに、画面を遷移させる
      builder: (BuildContext context) {
        return widget;
      },
    ));
  }

  Widget _copyrightDisplay(BuildContext context) {
    if (title == L10n.of(context).challenge) {
      return Container(
        height: 40,
        width: 40,
        child: FloatingActionButton(
            backgroundColor: Colors.blue[600],
            child: Icon(
              Icons.layers,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  CopyrightAttributionPage()));
            }
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _iconLogo(BuildContext context, IconData icon, Widget widget, double fontSize, Color iconColor) { // アイコンに関するウィジェット
    return ClipRRect( // 円形に関するウィジェット
      borderRadius: BorderRadius.circular(iconSizeWidth / 2), // 円形にする
      child: Container(
        height: iconSizeHeight,
        width: iconSizeWidth,
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

  Widget _iconName(BuildContext context, String name, Widget widget) { // アイコン下の文字に関するウィジェット
    return GestureDetector(
      onTap: () => _navigateToConverter(context, widget),
      child: Text( // 文字に関するウィジェット
        name,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: textFontSize,
          fontWeight: FontWeight.bold, // 太字
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 480) {
      iconSizeHeight = 150;
      iconSizeWidth = 150;
      iconFontSize = 90;
      textFontSize = 40;
    } else if (MediaQuery.of(context).size.width < 960) {
      iconSizeHeight = 300;
      iconSizeWidth = 300;
      iconFontSize = 180;
      textFontSize = 80;
    }

    return Scaffold( // 足場に関するウィジェット
      appBar: AppBar(
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
      floatingActionButton: _copyrightDisplay(context),
      body: SafeArea(
        child: Center(
          child: Column( // 縦の行
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[ // Spacer()は、空白の比率
              Spacer(flex: 10),
              _iconLogo(context, firstIconData, firstWidget, firstFontSize, iconColor), // 画像をアイコンとして生成して、iconLogoに渡す
              Spacer(),
              _iconName(context, firstButtonName, firstWidget), // アイコン下の文字に関する処理
              Spacer(flex: 15),
              _iconLogo(context, secondIconData, secondWidget, secondFontSize, iconColor),
              Spacer(),
              _iconName(context, secondButtonName, secondWidget),
              Spacer(flex: 10),
            ],
          ),
        ),
      ),
    );
  }
}
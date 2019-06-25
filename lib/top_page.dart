import 'package:flutter/material.dart';

import 'package:country_quiz/country_list.dart';

class TopPage extends StatelessWidget { // トップページに関するウィジェット

  void _navigateToConverter(BuildContext context) { // 画面遷移に関するウィジェット(ナビゲーターで管理)
    Navigator.of(context).push(MaterialPageRoute<Null>( // CountryListウィジェットに、画面を遷移させる
      builder: (BuildContext context) {
        return CountryList();
      },
    ));
  }

  Widget _iconLogo(BuildContext context, IconData icon) { // アイコンに関するウィジェット
    return ClipRRect( // 円形に関するウィジェット
      borderRadius: BorderRadius.circular(75.0), // 円形にする
      child: Container(
        height: 150,
        width: 150,
        color: Colors.tealAccent[700],
        child: FlatButton(
          onPressed: () => _navigateToConverter(context), // アイコンをクリックした場合の処理
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconName(BuildContext context, String name) { // アイコン下の文字に関するウィジェット
    return Text( // 文字に関するウィジェット
      name,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.bold, // 太字
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 足場に関するウィジェット
      appBar: AppBar( // アップバーに関するウィジェット
        title: Text(
          'Country Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Column( // 縦の行
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[ // Spacer()は、空白の比率
            Spacer(flex: 10),
            _iconLogo(context, IconData(0xe800, fontFamily: 'Icon')), // 画像をアイコンとして生成して、iconLogoに渡す
            Spacer(),
            _iconName(context, 'List'), // アイコン下の文字に関する処理
            Spacer(flex: 15),
            _iconLogo(context, Icons.gamepad),
            Spacer(),
            _iconName(context, 'Test'),
            Spacer(flex: 10),
          ],
        ),
      ),
    );
  }
}

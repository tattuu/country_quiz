import 'package:flutter/material.dart';

import 'package:country_quiz/top_page.dart'; // トップページをインポート
import 'package:country_quiz/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:country_quiz/country_list.dart';

void main() {
  SystemChrome.setPreferredOrientations( // 縦画面固定
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
} // エンドポイント(MyAppを実行する)

class MyApp extends StatelessWidget {
  // 状態を管理しない
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    Locale myLocale; // 言語設定に関する情報を入れる変数
    return MaterialApp( // マテリアルアップウィジェットで、基礎を作る
//      localeResolutionCallback: (deviceLocale, supportedLocales) { // 端末情報取得
//        myLocale = deviceLocale; // 現在のデバイス設定情報を代入
//        print(myLocale.countryCode); // 国コード
//        print(myLocale.languageCode); // 言語コード
//      },
      localizationsDelegates: [ // ローカライズに関するデリゲート
        L10n.delegate, // 独自設定した言語設定を適用
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [ // サポートする言語を指定
        Locale('ja'),
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false, // デバッグモードでの、右上のラベルを削除
      title: 'Country Quiz', // アプリのタイトル
      theme: ThemeData( // 背景やフォントのテーマ設定
        scaffoldBackgroundColor: Colors.white, // 背景色
        primaryColor: Colors.orange[600], // AppBarの色
        fontFamily: 'Roboto', // フォント名
      ),
      home: TopPage(),
      routes: <String, WidgetBuilder>{
        '/myapp': (BuildContext context) => TopPage(),
        '/country_list': (BuildContext context) => CountryList(),
      },// トップページの表示
    );
  }
}
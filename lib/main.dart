import 'package:flutter/material.dart';

import 'package:country_quiz/top_page.dart'; // トップページをインポート
import 'package:country_quiz/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rxdart/rxdart.dart';


void main() => runApp(MyApp()); // エンドポイント(MyAppを実行する)

class MyApp extends StatelessWidget {
  // 状態を管理しない
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Locale myLocale;
    return MaterialApp( // マテリアルアップウィジェットで、基礎を作る
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        myLocale = deviceLocale;
        print(myLocale.countryCode);
        print(myLocale.languageCode);
      },
      localizationsDelegates: [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
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
    );
  }
}
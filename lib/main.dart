import 'package:flutter/material.dart';

import 'package:country_quiz/top_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Quiz',
      theme: ThemeData(
//        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.orange[600],
      ),
//      home: CategoryRoute(),
      home: TopPage(),
    );
  }
}


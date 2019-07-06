import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';
import 'package:country_quiz/countDownPage.dart';
import 'package:country_quiz/trainingPage.dart';
import 'package:country_quiz/testPage.dart';

class SelectBattlePage extends StatelessWidget {
  // トップページに関するウィジェット

  @override
  Widget build(BuildContext context) {
    return TwoButtonBasePage(
      title: 'Challenge',
      firstButtonName: 'Trainng',
      secondButtonName: 'Test',
      firstIconData: IconData(0xe800, fontFamily: 'IconCards'),
      secondIconData: Icons.gamepad,
      firstWidget: CountDownPage(
          widget: TrainingPage(),
          backgroundColor: Colors.grey[100],
          barColor: Colors.white,
          charColor: Colors.orange,
      ),
      secondWidget: CountDownPage(
          widget: TestPage(),
          backgroundColor: Colors.grey[100],
          barColor: Colors.blue[600],
          charColor: Colors.orange,
      ),
      firstFontSize: 100.0,
      secondFontSize: 90.0,
      iconColor: Colors.blue[600],
    );
  }
}

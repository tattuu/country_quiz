import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';
import 'package:country_quiz/countDownPage.dart';
import 'package:country_quiz/trainingPage.dart';
import 'package:country_quiz/testPage.dart';
import 'package:country_quiz/l10n/l10n.dart';

class SelectBattlePage extends StatelessWidget {
  // トップページに関するウィジェット

  double firstFontSize;
  double secondFontSize;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 480) {
      firstFontSize = 100;
      secondFontSize = 90;
    } else if (MediaQuery.of(context).size.width < 960) {
      firstFontSize = 190;
      secondFontSize = 180;
    }

    return TwoButtonBasePage(
      title: L10n.of(context).challenge,
      firstButtonName: L10n.of(context).training,
      secondButtonName: L10n.of(context).test,
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
      firstFontSize: firstFontSize,
      secondFontSize: secondFontSize,
      iconColor: Colors.blue[600],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/countDownPage.dart';
import 'package:country_quiz/trainingPage.dart';
import 'package:country_quiz/testPage.dart';
import 'package:country_quiz/l10n/l10n.dart';

class SelectBattlePage extends StatelessWidget { // チャレンジページを作成するためのクラス

  @override
  Widget build(BuildContext context) {
    double firstFontSize;
    double secondFontSize;

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
      firstWidget: CountDownPage( // 1つ目のアイコンをクリックした時に遷移するカウントダウンページを表示
          widget: TrainingPage(), // カウントダウン後に遷移するトレーニングページを設定
          barColor: Colors.white,
      ),
      secondWidget: CountDownPage( // 1つ目のアイコンをクリックした時に遷移するカウントダウンページを表示
          widget: TestPage(), // カウントダウン後に遷移するテストページを設定
          barColor: Colors.blue[600],
      ),
      firstFontSize: firstFontSize,
      secondFontSize: secondFontSize,
      iconColor: Colors.blue[600],
    );
  }
}

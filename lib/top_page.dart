import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';
import 'package:country_quiz/selectBattlePage.dart';

class TopPage extends StatelessWidget { // トップページに関するウィジェット

  @override
  Widget build(BuildContext context) {
    return TwoButtonBasePage(
      title: 'Country Quiz',
      firstButtonName: 'List',
      secondButtonName: 'Test',
      firstIconData: IconData(0xe800, fontFamily: 'Icon'),
      secondIconData: Icons.gamepad,
      firstWidget: CountryList(),
      secondWidget: SelectBattlePage(),
      firstFontSize: 80.0,
      secondFontSize: 85.0,
      iconColor: Colors.tealAccent[700],
    );
  }
}
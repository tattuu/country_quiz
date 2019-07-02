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
      secondButtonName: 'Challenge',
      firstIconData: IconData(0xe800, fontFamily: 'IconGlobe'),
      secondIconData: IconData(0xe800, fontFamily: 'IconDumbbellAndBarbell'),
      firstWidget: CountryList(),
      secondWidget: SelectBattlePage(),
      firstFontSize: 90.0,
      secondFontSize: 90.0,
      iconColor: Colors.tealAccent[700],
    );
  }
}
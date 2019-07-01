import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';


class SelectBattlePage extends StatelessWidget {
  // トップページに関するウィジェット

  @override
  Widget build(BuildContext context) {
    return TwoButtonBasePage(
      title: 'Test',
      firstButtonName: 'Single',
      secondButtonName: 'Multi',
      firstIconData: Icons.person,
      secondIconData: Icons.people,
      firstWidget: CountryList(),
      secondWidget: CountryList(),
      firstFontSize: 85.0,
      secondFontSize: 85.0,
      iconColor: Colors.blue[600],
    );
  }
}

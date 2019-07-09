import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';
import 'package:country_quiz/selectBattlePage.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/l10n/l10n.dart';

class TopPage extends StatelessWidget { // トップページに関するウィジェット

  List<Country> _countryImageNames = [];
  List<Image> _countryImageWidget = [];
  double firstFontSize;
  double secondFontSize;

  void _setImageCache(BuildContext context) {
    _countryImageNames = countryList(context).where(acceptAllCountries).toList();
    _countryImageNames.forEach((country) =>
      _countryImageWidget.add(
        Image.asset(
          CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
          height: 30.0,
          width: 50.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    _setImageCache(context);

    if (MediaQuery.of(context).size.width < 480) {
      firstFontSize = 90;
      secondFontSize = 90;
    } else if (MediaQuery.of(context).size.width < 960) {
      firstFontSize = 190;
      secondFontSize = 180;
    }


    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.0,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) => _countryImageWidget[index],
            itemCount: _countryImageWidget.length,
          ),
        ),
        TwoButtonBasePage(
          title: 'Country Quiz',
          firstButtonName: L10n.of(context).list,
          secondButtonName: L10n.of(context).challenge,
          firstIconData: IconData(0xe800, fontFamily: 'IconGlobe'),
          secondIconData: IconData(0xe800, fontFamily: 'IconDumbbellAndBarbell'),
          firstWidget: CountryList(),
          secondWidget: SelectBattlePage(),
          firstFontSize: firstFontSize,
          secondFontSize: secondFontSize,
          iconColor: Colors.tealAccent[700],
        ),
      ]
    );
  }
}
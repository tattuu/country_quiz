import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';
import 'package:country_quiz/selectBattlePage.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';

class TopPage extends StatelessWidget { // トップページに関するウィジェット

  List<Country> _countryImageNames = [];
  List<Image> _countryImageWidget = [];

  void _setImageCache() {
    _countryImageNames = countryList.where(acceptAllCountries).toList();
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

    _setImageCache();

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
          firstButtonName: 'List',
          secondButtonName: 'Challenge',
          firstIconData: IconData(0xe800, fontFamily: 'IconGlobe'),
          secondIconData: IconData(0xe800, fontFamily: 'IconDumbbellAndBarbell'),
          firstWidget: CountryList(),
          secondWidget: SelectBattlePage(),
          firstFontSize: 90.0,
          secondFontSize: 90.0,
          iconColor: Colors.tealAccent[700],
        ),
      ]
    );
  }
}
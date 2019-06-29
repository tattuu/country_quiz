import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CountryPickerUtils {
  static Country getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere(
        (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/countries/flags2/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(Country country) {
    return Image.asset(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.contain,
    );
  }

//  static Country getCountryByPhoneCode(String phoneCode) {
//    try {
//      return countryList.firstWhere(
//        (country) => country.phoneCode.toLowerCase() == phoneCode.toLowerCase(),
//      );
//    } catch (error) {
//      throw Exception(
//          "The initialValue provided is not a supported phone code!");
//    }
//  }
}

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:flutter/material.dart';

/// Returns true when a country should be included in lists / dialogs
/// offered to the user.
typedef bool ItemFilter(Country country);

typedef Widget ItemBuilder(Country country);

/// Simple closure which always returns true.
bool acceptAllCountries(_) => true;

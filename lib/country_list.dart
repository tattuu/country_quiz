import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:country_quiz/create_one_country_column.dart';

import 'package:country_quiz/unit.dart';

class CountryList extends StatefulWidget {

  const CountryList();

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {

  final _categories = <CreateOneCountryColumn>[];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (_categories.isEmpty) {
      await _retrieveCountryList();
    }
  }
  Future<void> _retrieveCountryList() async {

    final json = DefaultAssetBundle.of(context).loadString(
        'assets/json/country_list.json');
    final data = JsonDecoder().convert(await json);

    data.keys.forEach((key) {
      if (data is! Map) {
        throw('data got is not a Map');
      }
      final List<Unit> units =
        data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

      units.forEach((Unit unit) {
        var countryList = CreateOneCountryColumn(
          name: unit.name,
          color: Colors.grey[100],
          flagImagePath: unit.flagPath,
//          units: units,
        );

        setState(() {
          _categories.add(countryList);
        });
      });
    });
  }

  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {

    final listView = Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      color: Colors.grey[50],
      child: _buildCategoryWidgets(_categories),
    );

    return Scaffold(
      body: listView,
    );
  }
}
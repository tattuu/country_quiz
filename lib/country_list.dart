import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:country_quiz/create_one_country_column.dart';
import 'package:country_quiz/unit.dart';

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country_picker_dialog.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';

class CountryList extends StatefulWidget {

  const CountryList();

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  Country _selectedDialogCountry =
    CountryPickerUtils.getCountryByPhoneCode('599');

  TextEditingController controller;

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
//      color: Colors.grey[50],
      child: _buildCategoryWidgets(_categories),
    );

    return Scaffold(
      floatingActionButton: Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.pink,
            child: Icon(
              Icons.chevron_left,
              size: 45,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.pink,
              child: Icon(
                Icons.search,
                size: 34,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _searchOfCountry(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: listView,
    );
  }

  Widget _searchOfCountry(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      children: <Widget>[
        SimpleDialogOption(
          child: Form(
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: _openCountryPickerDialog,
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
                Text(
                    'オセアニア'
                ),

                IconButton(
                  icon: Icon(Icons.done_outline),
                  iconSize: 35,
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.pink),
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.pinkAccent,
        searchInputDecoration: InputDecoration(hintText: 'Search...'),
        isSearchable: true,
        title: Text('Select your phone code'),
        onValuePicked: (Country country) =>
            setState(() => _selectedDialogCountry = country),
        itemBuilder: _buildDialogItem
      ),
    ),
  );

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.name))
    ],
  );
}
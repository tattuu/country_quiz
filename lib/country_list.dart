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
  final continentTag = ['アジア', 'ヨーロッパ', '北アメリカ','南アメリカ', 'オセアニア', 'アフリカ'];

  final _tagColor = [];
  final searchResults = <String>[];

  Country _selectedDialogCountry =
    CountryPickerUtils.getCountryByIsoCode('JP');

  dynamic _listTileSet = Text('Search...');

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

    continentTag.forEach((continent) {
      _tagColor.add({continent: [Colors.black, Colors.white]});
    });

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
                for (var i = 0; i < continentTag.length; i++){
                    _tagColor[i][continentTag[i]] = [Colors.black, Colors.white];
                }
                _listTileSet = Text('Search...');
                searchResults.clear();
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

                _searchForm(),

                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                IconButton(
                  icon: Icon(Icons.done_outline),
                  iconSize: 35,
                  onPressed: () {
                    print('finish');
                    print(searchResults);
                    if(searchResults.length != 0) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openCountryPickerDialog() async =>
      await showDialog(
        context: context,
        builder: (context) =>
           Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: EdgeInsets.only(top: 1.0),
                searchCursorColor: Colors.pink,
                searchInputDecoration: InputDecoration(
                    hintText: 'Search...'
                ),
                isSearchable: true,
//                  title: Text('国を検索して下さい'),
                onValuePicked: (Country country) {
                  setState(() {
                    _selectedDialogCountry = country;
                    _listTileSet =  _buildDialogItem(_selectedDialogCountry);
                    for (var i = 0; i < continentTag.length; i++){
                      _tagColor[i][continentTag[i]] = [Colors.black, Colors.white];
                    }
                  });
                  searchResults.clear();
                  searchResults.add(_selectedDialogCountry.jpName);
                  print("フォーム");
                  print(searchResults);
                },
                itemBuilder: _buildDialogItem
            ),
          ),
      );

  Widget _buildDialogItem(Country country) =>
    Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(width: 12.0),
        //      Text("+${country.phoneCode}"),
        //      SizedBox(width: 8.0),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Text(country.jpName),
          ),
        ),
      ],
    );

  Widget _cardSearch () {

    return SizedBox(
      height: 65.0,
      child: Card(
        elevation: 3.0,
        color: Colors.grey[300],
        child: ListTile(
            onTap: _openCountryPickerDialog,
            title: _listTileSet,
          ),
        ),
      );
  }

  Widget _oneTag(String tagName, int setNum) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 2.0,
          color:  _tagColor[setNum][tagName][0],
        ),
        color:  _tagColor[setNum][tagName][1],
      ),
      margin: EdgeInsets.only(left: 5.0),
      padding: EdgeInsets.all(7.0),
      child: Center(
        child: GestureDetector(
          onTap: () {

            setState(() {
              _listTileSet = Text('Search...');
            });

            final matchCountry = searchResults.where((searchResult) => searchResult == _selectedDialogCountry.jpName);
            if (matchCountry.length != 0) {
              searchResults.clear();
            }

            print('押されたタグ');
            print(tagName);
            final matchCategory = searchResults.where((searchResult) => searchResult == tagName);
            if (matchCategory.length != 0) {
              searchResults.removeAt(searchResults.indexOf(tagName));
              setState(() {
                _tagColor[setNum][tagName][0] = Colors.black;
                _tagColor[setNum][tagName][1] = Colors.white;
              });
            } else {
              setState(() {
                _tagColor[setNum][tagName][0] = Colors.white;
                _tagColor[setNum][tagName][1] = Colors.grey[700];
              });
              searchResults.add(tagName);
            }

            print('結果');
            print(searchResults);
          },
          child: Text(
            tagName,
            style: TextStyle(
              color:  _tagColor[setNum][tagName][0],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
  Widget _searchForm() {

    final children = <Widget>[];

    children.add(_cardSearch());
    children.add(
      Padding(
        padding: EdgeInsets.only(top: 20.0),
      ),
    );

    for (int i = 0; i < continentTag.length; i += 2) {
      children.add(
        Row(
          children: <Widget>[
            _oneTag(continentTag[i], i),
            _oneTag(continentTag[i + 1], i + 1),
          ],
        ),
      );
      children.add(
        Padding(
          padding: EdgeInsets.only(top: 5.0),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
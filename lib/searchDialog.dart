import 'package:flutter/material.dart';

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country_picker_dialog.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/l10n/l10n.dart';

class MainSearchDialog extends StatefulWidget {

  @override
  _MainSearchDialog createState() => _MainSearchDialog();
}

class _MainSearchDialog extends State<MainSearchDialog>{
  var countryFlagNames = <Country>[];
  final searchResults = <String>[];
  var continentTag;
  double tagRadius;
  double tagBorderSize;
  double tagFontSize;

  final _tagColor = [];

  Country _selectedDialogCountry;
//    CountryPickerUtils.getCountryByIsoCode('JP');

  dynamic _listTileSet = "Search";

  @override
  void initState() {


    _selectedDialogCountry = null;

    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_listTileSet == "Search") {
      _listTileSet = Text(
        '${L10n.of(context).search}...',
        style: TextStyle(
          fontSize: tagFontSize,
        ),
      );
    }

    continentTag = [
      L10n.of(context).asiaForSearchCategory,
      L10n.of(context).europeForSearchCategory,
      L10n.of(context).northAmericaForSearchCategory,
      L10n.of(context).southAmericaForSearchCategory,
      L10n.of(context).oceaniaForSearchCategory,
      L10n.of(context).africaForSearchCategory,
    ];

    for (var i = 0; i < continentTag.length; i++) {
      _tagColor.add({continentTag[i]: [Colors.black, Colors.white]});
    }
  }

  Widget _oneTag(String tagName, int setNum) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tagRadius),
          border: Border.all(
//            width: MediaQuery.of(context).size.width / 120,
            width: tagBorderSize,
          color: _tagColor[setNum][tagName][0],
          ),
          color: _tagColor[setNum][tagName][1],
        ),
        margin: EdgeInsets.only(left: 5.0),
        padding: EdgeInsets.all(7.0),
        child: Center(
          child: GestureDetector(
            onTap: () {

              if (_selectedDialogCountry != null){
                _selectedDialogCountry = null;
                searchResults.clear();
                searchResults.add(tagName);
                setState(() {
                  _listTileSet = Text(
                    '${L10n.of(context).search}...',
                    style: TextStyle(
                      fontSize: tagFontSize * 1.2,
                    ),
                  );
                });
              } else {
                if (searchResults.length != 0) {
                  var checkFlag = false;
                  for (int i = 0; i < searchResults.length; i++) {
                    if (searchResults[i] == tagName) {
                      searchResults.removeAt(i);
                      checkFlag = true;
                    }
                  }
                  if (!checkFlag) {
                    searchResults.add(tagName);
                  }
                } else {
                  searchResults.add(tagName);
                }
              }

              setState(() {
                _tagColor[setNum][tagName][0] == Colors.black ? _tagColor[setNum][tagName][0] = Colors.white: _tagColor[setNum][tagName][0] = Colors.black;
                _tagColor[setNum][tagName][1] == Colors.white ? _tagColor[setNum][tagName][1] = Colors.grey: _tagColor[setNum][tagName][1] = Colors.white;
              });
            },
            child: Text(
              tagName,
              style: TextStyle(
                color: _tagColor[setNum][tagName][0],
                fontWeight: FontWeight.w300,
                fontSize: tagFontSize,
              ),
            ),
          ),
        ),
      );

  void _openCountryPickerDialog() async =>
      await showDialog(
        context: context,
        builder: (context) =>
            Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.pink),
              child: CountryPickerDialog(
                  titlePadding: EdgeInsets.only(top: 1.0),
                  searchCursorColor: Colors.pink,
                  searchInputDecoration: InputDecoration(
                    hintText: '${L10n.of(context).search}...',
                  ),
                  isSearchable: true,
//                  title: Text('国を検索して下さい'),
                  onValuePicked: (Country country) {
                    setState(() {
                      _selectedDialogCountry = country;
                      _listTileSet = _buildDialogItem(_selectedDialogCountry);
                      for (var i = 0; i < continentTag.length; i++) {
                        _tagColor[i][continentTag[i]] = [Colors.black, Colors.white];
                      }
                    });
                    searchResults.clear();
                    searchResults.add(_selectedDialogCountry.name);

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
//            padding: EdgeInsets.only(bottom: 3.0),
              child: Text(
                country.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _cardSearch() {
    return SizedBox(
//      height: 45.0,
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

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 480) {
      tagBorderSize = MediaQuery.of(context).size.width / 180;
      tagRadius = MediaQuery.of(context).size.width / 15;
      tagFontSize = 15.0;
    } else if (MediaQuery.of(context).size.width < 960) {
      tagBorderSize = MediaQuery.of(context).size.width / 120;
      tagRadius = MediaQuery.of(context).size.width / 20;
      tagFontSize = 20.0;

    }
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
                    iconSize: MediaQuery.of(context).size.width / 10,
                    onPressed: () {
                      if (searchResults.length != 0) {
                        setState(() {

                          var continentHit = [];

                          countryFlagNames = countryList(context).where((country) =>
                          searchResults.indexOf(country.name) > -1).toList();

                          if (countryFlagNames.length == 0) {
                            countryList(context).forEach((country) =>
                                continentHit.add(country.continents.where((
                                    countryContinent) =>
                                searchResults.indexOf(countryContinent) > -1)
                                    .toList()));

                            for (var i = 0; i < continentHit.length; i++) {
                              if (continentHit[i].length != 0) {
                                countryFlagNames.add(countryList(context)[i]);
                              }
                            }
                          }

                          Navigator.pop(context, countryFlagNames);
                        });
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/create_one_country_column.dart';

import 'package:country_quiz/fix_pub_lib/unicorndial_1.1.5_fix/unicorndial.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';

import 'package:country_quiz/l10n/l10n.dart';

class SearchResult extends StatefulWidget {

  final searchResult;

  const SearchResult({this.searchResult});

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  final categories = <CreateOneCountryColumn>[];
  ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    await retrieveCountryList();
  }

  Future<void> retrieveCountryList() async {
    setState(() {
      widget.searchResult.forEach((countryFlagName) {
        categories.add(CreateOneCountryColumn(
          isoCode: countryFlagName.isoCode,
          name: countryFlagName.name,
          flagImagePath: CountryPickerUtils.getFlagImageAssetPath(
              countryFlagName.isoCode),
          //          units: units,
        ));
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) => categories[index],
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {

    final listView = Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildCategoryWidgets(categories),
    );

    return WillPopScope( // 端末下の戻るボタンを押したときの処理
      onWillPop: () {
        Navigator.of(context)
          ..pop()
          ..pop();
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton:FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.tealAccent[700],
            child: Icon(
              Icons.chevron_left,
              size: 47,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          body: listView,
        ),
      ),
    );
  }
}
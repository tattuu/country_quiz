import 'package:flutter/material.dart';
import 'dart:async';

import 'package:country_quiz/create_one_country_column.dart';

import 'package:country_quiz/fix_pub_lib/unicorndial_1.1.5_fix/unicorndial.dart';

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/searchDialog.dart';
import 'package:country_quiz/l10n/l10n.dart';
import 'package:country_quiz/searchResult.dart';

class CountryList extends StatefulWidget {

  const CountryList();

  @override
  CountryListState createState() => CountryListState();
}

class CountryListState extends State<CountryList> {
//  var indicator = GlobalKey<RefreshIndicatorState>();
//   _CountryListState({Key indicator});
  ScrollController _scrollController;
//  TextEditingController controller;

//  StreamController<CreateOneCountryColumn> _controller = StreamController<CreateOneCountryColumn>();

  var countryFlagNames = <Country>[];
  final categories = <CreateOneCountryColumn>[];
//  var countryFlagNames = <Country>[];
//

  static CountryListState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<CountryListState>());
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Future<void> didChangeDependencies() async {
    countryFlagNames = countryList(context).where(acceptAllCountries).toList();

    super.didChangeDependencies();

    if (categories.isEmpty) {
      await retrieveCountryList();
    }
  }

  Future<void> retrieveCountryList() async {
    setState(() {
      categories.clear();
      countryFlagNames.forEach((countryFlagName) {
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

//  _scrollToTop() {
//    if (_scrollController.position.pixels < 8000.0) {
//      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
//      print(_scrollController.position.maxScrollExtent / 2);
//    } else {
//      _scrollController.animateTo(_scrollController.position.minScrollExtent,
//          duration: Duration(milliseconds: 10000),
//          curve: Curves.easeIn);
//    }
//  }

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
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: L10n.of(context).search,
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.lightBlue,
        child: Icon(
          Icons.search,
          size: 36,
        ),
        onPressed: () async {
//          var keepCountryFlagNames = countryFlagNames;
          countryFlagNames = await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) {
              return MainSearchDialog();
            },
          );
          setState(() {
            if (countryFlagNames != null){
              Navigator.of(context).push(MaterialPageRoute( // 指定した画面関連ウィジェットに遷移する
                builder: (BuildContext context) {
                  return SearchResult(searchResult: countryFlagNames);
                },
              ));
            }
          });
        },
      ),
    ));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: L10n.of(context).reload,
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => CountryList()));
//          _scrollToTop();
//          countryFlagNames = countryList(context).where(acceptAllCountries).toList();
//          retrieveCountryList();
        },
      ),
    ));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: L10n.of(context).back,
      currentButton: FloatingActionButton(
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
    ));

    final listView = Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildCategoryWidgets(categories),
    );

    return SafeArea(
        child: Scaffold(
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: Colors.pink,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(
              Icons.add,
            ),
            childPadding: 5.0,
            childButtons: childButtons),

        body: listView,
        ),
    );
  }
}

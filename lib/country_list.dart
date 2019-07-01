import 'package:flutter/material.dart';
import 'dart:async';

import 'package:country_quiz/create_one_country_column.dart';

import 'package:country_quiz/fix_pub_lib/unicorndial_1.1.5_fix/unicorndial.dart';

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/searchDialog.dart';


class CountryList extends StatefulWidget {

  const CountryList();

  @override
  CountryListState createState() => CountryListState();
}

class CountryListState extends State<CountryList> {
//  var indicator = GlobalKey<RefreshIndicatorState>();
//   _CountryListState({Key indicator});
  ScrollController _scrollController;
  TextEditingController controller;

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
    countryFlagNames = countryList.where(acceptAllCountries).toList();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollToTop() {
    _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.easeIn);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (categories.isEmpty) {
      await retrieveCountryList();
    }
  }

  Future<void> retrieveCountryList() async {
    setState(() {
      categories.clear();
      countryFlagNames.forEach((countryFlagName) {
        var countryList = CreateOneCountryColumn(
          isoCode: countryFlagName.isoCode,
          name: countryFlagName.jpName,
          color: Colors.grey[100],
          flagImagePath: CountryPickerUtils.getFlagImageAssetPath(
              countryFlagName.isoCode),
  //          units: units,
        );

        categories.add(countryList);
      });
    });
  }

  Widget _buildCategoryWidgets(List<Widget> categories) {
    return ListView.builder(
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
      labelText: "Search",
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.lightBlue,
        child: Icon(
          Icons.search,
          size: 36,
        ),
        onPressed: () async {
          var keepCountryFlagNames = countryFlagNames;
          countryFlagNames = await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) {
              return MainSearchDialog();
            },
          );
          setState(() {
            if (countryFlagNames == null){
              countryFlagNames = keepCountryFlagNames;
            }
            retrieveCountryList();
          });
        },
      ),
    ));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "Reload",
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
        onPressed: () {
          _scrollToTop();
          countryFlagNames = countryList.where(acceptAllCountries).toList();
          retrieveCountryList();
        },
      ),
    ));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "Back",
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.tealAccent[700],
        child: Icon(
          Icons.chevron_left,
          size: 47,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));

    final listView = Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildCategoryWidgets(categories),
    );

    return Scaffold(
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
    );
  }
}

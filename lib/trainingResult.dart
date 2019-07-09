import 'package:flutter/material.dart';
import 'package:country_quiz/create_one_country_column.dart';
import 'package:country_quiz/fix_pub_lib/unicorndial_1.1.5_fix/unicorndial.dart';

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/l10n/l10n.dart';

class TrainingResult extends StatefulWidget {

  final List<Country> knowCountryList;
  final List<Country> unKnowCountryList;

  const TrainingResult({this.knowCountryList, this.unKnowCountryList});

  @override
  _TrainingResultState createState() => _TrainingResultState();
}

class _TrainingResultState extends State<TrainingResult> with TickerProviderStateMixin{

  ScrollController _scrollController;
  var knowCountryWidgetColumn = <CreateOneCountryColumn>[];
  var unKnowCountryWidgetColumn = <CreateOneCountryColumn>[];
  var tabs;

  @override
  void initState() {
    super.initState();

//    _tabController = TabController(length: tabs.length, vsync: this);
    _scrollController = ScrollController();

  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    tabs = <Tab>[
      Tab(
        text: L10n.of(context).know,
      ),
      Tab(
        text: L10n.of(context).unKnow,
      ),
    ];

    if (knowCountryWidgetColumn.isEmpty) {
      await retrieveCountryList();
    }
  }

  Future<void> retrieveCountryList() async {
    setState(() {
      knowCountryWidgetColumn.clear();
      widget.knowCountryList.forEach((knowCountry) {
        knowCountryWidgetColumn.add(CreateOneCountryColumn(
          isoCode: knowCountry.isoCode,
          name: knowCountry.name,
          color: Colors.grey[100],
          flagImagePath: CountryPickerUtils.getFlagImageAssetPath(
              knowCountry.isoCode),
        ));
      });
      widget.unKnowCountryList.forEach((unKnowCountry) {
        unKnowCountryWidgetColumn.add(CreateOneCountryColumn(
          isoCode: unKnowCountry.isoCode,
          name: unKnowCountry.name,
          color: Colors.grey[100],
          flagImagePath: CountryPickerUtils.getFlagImageAssetPath(
              unKnowCountry.isoCode),
        ));
      });
    });
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
      labelText: "${L10n.of(context).reload}",
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
        onPressed: () {
          _scrollToTop();
          retrieveCountryList();
        },
      ),
    ));
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "${L10n.of(context).back}",
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.tealAccent[700],
        child: Icon(
          Icons.chevron_left,
          size: 47,
        ),
        onPressed: () {
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop();
        },
      ),
    ));

    final knowListView = Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildCategoryWidgets(knowCountryWidgetColumn),
    );

    final unKnowListView = Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildCategoryWidgets(unKnowCountryWidgetColumn),
    );

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
          ..pop()
          ..pop()
          ..pop();
      },
      child: SafeArea(
        child: DefaultTabController(
        length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.blueAccent,
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
  //                indicatorPadding: EdgeInsets.only(bottom: 100),
                  indicatorWeight: 10,
  //                indicator: BoxDecoration(
  //                  color: Colors.blue,
  //                  borderRadius: BorderRadius.circular(30),
  //                ),
  //                indicatorSize: ,
                  tabs: tabs,
                ),
              ),
            ),
            floatingActionButton: UnicornDialer(
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
                parentButtonBackground: Colors.pink,
                orientation: UnicornOrientation.VERTICAL,
                parentButton: Icon(
                  Icons.add,
                ),
                childPadding: 5.0,
                childButtons: childButtons),

            body: TabBarView(children: [
              knowListView,
              unKnowListView,
            ]),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:country_quiz/create_one_country_column.dart';
import 'package:country_quiz/fix_pub_lib/unicorndial_1.1.5_fix/unicorndial.dart';

import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/l10n/l10n.dart';

class ChallengeResult extends StatefulWidget { // Statefulなウィジェットととして設定

  final List<Country> knowCountryList; // トレーニングの結果、知っている国として分類した国の一覧が入ったリスト
  final List<Country> unKnowCountryList; // トレーニングの結果、知っていない国として分類した国の一覧が入ったリスト

  const ChallengeResult({this.knowCountryList, this.unKnowCountryList});

  @override
  _ChallengeResultState createState() => _ChallengeResultState();
}

class _ChallengeResultState extends State<ChallengeResult> with TickerProviderStateMixin{

  ScrollController _scrollController;
  var knowCountryWidgetColumn = <CreateOneCountryColumn>[]; // 知っている国を表示するリストの1列分のウィジェットが表示される
  var unKnowCountryWidgetColumn = <CreateOneCountryColumn>[]; // 知っていない国を表示するリストの1列分のウィジェットが表示される
  var tabs; // タブの情報が入る

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(); // リストのスクロールに関するコントローラの設定
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    tabs = <Tab>[  // タブのリスト
      Tab(
        text: L10n.of(context).know, // 知っている国の一覧を表示しているページについてのタブ
      ),
      Tab(
        text: L10n.of(context).unKnow,  // 知っていない国の一覧を表示しているページについてのタブ
      ),
    ];

    if (knowCountryWidgetColumn.isEmpty && unKnowCountryWidgetColumn.isEmpty) { //
      await retrieveCountryList();
    }
  }

  Future<void> retrieveCountryList() async { // 知っている国と知っていない国のそれぞれの1列ずつをListに格納するウィジェット
    setState(() {
      knowCountryWidgetColumn.clear();
      widget.knowCountryList.forEach((knowCountry) {
        knowCountryWidgetColumn.add(CreateOneCountryColumn( // 作成した各国に対するListView内の1列のウィジェットを作成し、リストに追加
          isoCode: knowCountry.isoCode,
          name: knowCountry.name,
          flagImagePath: CountryPickerUtils.getFlagImageAssetPath(
              knowCountry.isoCode),
        ));
      });
      widget.unKnowCountryList.forEach((unKnowCountry) {
        unKnowCountryWidgetColumn.add(CreateOneCountryColumn(
          isoCode: unKnowCountry.isoCode,
          name: unKnowCountry.name,
          flagImagePath: CountryPickerUtils.getFlagImageAssetPath(
              unKnowCountry.isoCode),
        ));
      });
    });
  }

  @override
  void dispose() { // このウィジェットを消して、メモリを開放する
    _scrollController.dispose();
    super.dispose();
  }

  _scrollToTop() { // リストの先頭に移動する
    if (_scrollController.position.pixels < 8000.0) {
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      print(_scrollController.position.maxScrollExtent / 2);
    } else {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 10000),
          curve: Curves.easeIn);
    }
  }

  Widget _buildMakeCountryList(List<Widget> countriesColumnList) { // ListViewにする1列の要素が入ったリストから、ListViewを作成する
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) => countriesColumnList[index],
      itemCount: countriesColumnList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>(); // floatingActionButtonに関するボタン

    childButtons.add(UnicornButton( // floatingActionButtonを作成
      hasLabel: true, // ラベルを持つ事を許可
      labelText: "${L10n.of(context).reload}", // ラベルを表示
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.refresh,
          size: 40,
        ),
        onPressed: () { // タップした場合、リストビューを先頭に移動し、
          _scrollToTop(); // リストの先頭に移動
//          retrieveCountryList();
        },
      ),
    ));
    childButtons.add(UnicornButton( // 戻るボタンを押したと時の処理
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

    final knowListView = Container( // 知っている国に関するリストのコンテナ
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildMakeCountryList(knowCountryWidgetColumn), // リスト本体
    );

    final unKnowListView = Container( // 知っていない国に関するリストのコンテナ
      padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
      child: _buildMakeCountryList(unKnowCountryWidgetColumn), // リスト本体
    );

    return WillPopScope( // 端末下の戻るボタンを押したときの処理
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
            appBar: AppBar( // アップバーの設置
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: TabBar( // タブバーの設置
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
                  tabs: tabs, // tab本体の設定
                ),
              ),
            ),
            floatingActionButton: UnicornDialer( // floatingActionButtonの設置
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
                parentButtonBackground: Colors.pink,
                orientation: UnicornOrientation.VERTICAL,
                parentButton: Icon(
                  Icons.add,
                ),
                childPadding: 5.0,
                childButtons: childButtons),

            body: TabBarView(children: [ // それぞれのタブで表示する内容を設置
              knowListView,
              unKnowListView,
            ]),
          ),
        ),
      ),
    );
  }
}
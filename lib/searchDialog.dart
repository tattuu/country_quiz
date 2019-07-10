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

class _MainSearchDialog extends State<MainSearchDialog>{ // サーチダイアログのメイン部分
  final searchResults = <String>[]; // 検索結果の文字列が入る変数
  final _tagColor = []; // タグの色
  var countryObjectList = <Country>[]; // カントリーオブジェクトが入るリスト
  var continentTag; // 大陸の名前のタグ
  double tagRadius; // タグの丸み
  double tagBorderSize; // タグの枠線の太さ
  double tagFontSize; // タグの文字サイズ
  Country _selectedDialogCountry; // 検索結果の国のオブジェクトを代入
  dynamic _listTileSet = "Search"; // 検索フォームに表示されるオブジェクト

  @override
  void initState() {
    _selectedDialogCountry = null;
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_listTileSet == "Search") { // 開かれた直後の場合
      _listTileSet = Text( // Search...を表示
        '${L10n.of(context).search}...',
        style: TextStyle(
          fontSize: tagFontSize,
        ),
      );
    }

    continentTag = [ // タグの要素を追加
      L10n.of(context).asiaForSearchCategory,
      L10n.of(context).europeForSearchCategory,
      L10n.of(context).northAmericaForSearchCategory,
      L10n.of(context).southAmericaForSearchCategory,
      L10n.of(context).oceaniaForSearchCategory,
      L10n.of(context).africaForSearchCategory,
    ];

    for (var i = 0; i < continentTag.length; i++) { //各タグの色を設定
      _tagColor.add({continentTag[i]: [Colors.black, Colors.white]});
    }
  }

  Widget _oneTag(String tagName, int setNum) => // タグに関するウィジェット
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
            onTap: () { // タグをタップした時
              if (_selectedDialogCountry != null){ // 検索フォームで国が検索されている場合
                _selectedDialogCountry = null; // 検索フォームの検索結果に対応した変数をリセットし、検索フォームで検索していない状態に戻す
                searchResults.clear(); // 検索結果のリストをクリアし、何も検索されていない状態にするために、1度リセット
                searchResults.add(tagName); // 空の検索結果リストにタップしたタグの名前を追加
                setState(() {
                  _listTileSet = Text( // 検索フォームに表示するオブジェクトを、検索をしていない状態のオブジェクトに戻す
                    '${L10n.of(context).search}...',
                    style: TextStyle(
                      fontSize: tagFontSize * 1.2,
                    ),
                  );
                });
              } else { // 検索フォームで国が検索されていない場合
                if (searchResults.length != 0) { // 何かのタグが既に押されていた場合
                  var checkFlag = false; //  タップしたタグが既に押されていたかどうかをチェックするためのフラグ
                  for (int i = 0; i < searchResults.length; i++) { // 既に押されているタグの数だけ回す
                    if (searchResults[i] == tagName) { // タップしたタグを既にタップしていた場合
                      searchResults.removeAt(i); // 検索結果からタップされたタグを消す
                      checkFlag = true; // タップしたタグが、既に押されていた事を示す
                    }
                  }
                  if (!checkFlag) { // タップしたタグが押されていなかった場合
                    searchResults.add(tagName); // タップしたタグを追加
                  }
                } else { // 何も検索していなかった場合
                  searchResults.add(tagName); // タップしたタグを追加
                }
              }

              setState(() {
                _tagColor[setNum][tagName][0] == Colors.black ? _tagColor[setNum][tagName][0] = Colors.white: _tagColor[setNum][tagName][0] = Colors.black; // タグの色を変更
                _tagColor[setNum][tagName][1] == Colors.white ? _tagColor[setNum][tagName][1] = Colors.grey: _tagColor[setNum][tagName][1] = Colors.white; // タグの色を変更
              });
            },
            child: Text( // タグに表示する名前に関するウィジェット
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

  void _openCountryPickerDialog() async => // 検索ダイアログ内の検索フォームが押された時に表示されるダイアログに関するメソッド
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
                _selectedDialogCountry = country; // クリックされた国をフォーム検索結果として代入
                _listTileSet = _buildDialogItem(_selectedDialogCountry); // 検索フォームの表示形式を、検索フォームで検索された状態の表示にするために、_listTileSetを更新
                for (var i = 0; i < continentTag.length; i++) { // タグ数だけ回す
                  _tagColor[i][continentTag[i]] = [Colors.black, Colors.white]; // タグを押されていない状態にするために、色をリセット
                }
              });
              searchResults.clear(); // 検索結果を1度リセット
              searchResults.add(_selectedDialogCountry.name); // 検索結果に、検索フォームを用いて検索した国オブジェクトを追加

            },
            itemBuilder: _buildDialogItem // 各国に関するデータを国の数だけ渡す
          ),
        ),
    );


  Widget _buildDialogItem(Country country) => // 検索フォームクリック時に表示される各国のデータの1列分に関するメソッド
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

  Widget _cardSearch() { // SearchDialog内の、検索フォーム部分
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

  Widget _searchForm() { // SearchDialogの検索フォーム&タグ部分
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
    return SimpleDialog( // 検索ダイアログの本体
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

                          countryObjectList = countryList(context).where((country) =>
                            searchResults.indexOf(country.name) > -1).toList();

                          if (countryObjectList.length == 0) {
                            countryList(context).forEach((country) =>
                                continentHit.add(country.continents.where((
                                    countryContinent) =>
                                      searchResults.indexOf(countryContinent) > -1).toList()));

                            for (var i = 0; i < continentHit.length; i++) {
                              if (continentHit[i].length != 0) {
                                countryObjectList.add(countryList(context)[i]);
                              }
                            }
                          }

                          Navigator.pop(context, countryObjectList);
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
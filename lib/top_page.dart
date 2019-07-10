import 'package:flutter/material.dart';

import 'package:country_quiz/twoButtonBasePage.dart';
import 'package:country_quiz/country_list.dart';
import 'package:country_quiz/selectBattlePage.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/l10n/l10n.dart';

// ignore: must_be_immutable
class TopPage extends StatelessWidget { // トップページに関するクラス

  List<Country> _countryList = []; // カントリークラスが入るリスト
  List<Image> _countryImageWidgetList = []; // それぞれのカントリークラスを用いて、それぞれのイメージウィジェットを作成

  void _setImageCache(BuildContext context) { // Imageデータをキャッシュするために、前もってトップページにImageを表示させておく
    _countryList = countryList(context).where(acceptAllCountries).toList(); // 各国に対応したカントリークラスを全てリストに代入
    _countryList.forEach((country) => // 各国のデータを取り出す
      _countryImageWidgetList.add( // 取り出した国に、以下の要素を追加する
        Image.asset( // イメージウィジェットを作成
          CountryPickerUtils.getFlagImageAssetPath(country.isoCode), // getFlagImageAssetPathメソッドでイメージパスを取得
          height: 30.0, // 大きくある必要がないので、処理を早くするため、小さく作る
          width: 50.0, // 大きくある必要がないので、処理を早くするため、小さく作る
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) { // ビルドポイント
    double firstFontSize; // 1つ目のアイコンの下の文字サイズ
    double secondFontSize; // 2つ目のアイコンの下の文字サイズ

    _setImageCache(context); // イメージウィジェットを_countryImageWidgetListを完成させる

    if (MediaQuery.of(context).size.width < 480) { // スマホ対応
      firstFontSize = 90;
      secondFontSize = 90;
    } else if (MediaQuery.of(context).size.width < 960) { // タブレット対応
      firstFontSize = 190;
      secondFontSize = 180;
    }


    return Stack( // ウィジェットをStackする(重ねる)
      children: <Widget>[
        Opacity( // イメージデータをキャッシュするために表示するイメージウィジェットをopacityで完全透明に設定
          opacity: 0.0,
          child: ListView.builder( // ListViewを用いて、リスト形式でイメージでウィジェットを表示
            itemBuilder: (BuildContext context, int index) => _countryImageWidgetList[index], // itemCountで設定した数だけ回す(indexには回した数が表示される)
            itemCount: _countryImageWidgetList.length, // _countryImageWidgetListの数を設定
          ),
        ),
        TwoButtonBasePage( // 二つのアイコンボタンを表示するためのクラス
          title: 'Country Quiz', // タイトル
          firstButtonName: L10n.of(context).list, // 1つ目(上)のボタンの名前
          secondButtonName: L10n.of(context).challenge, // 2つ目(下)のボタンの名前
          firstIconData: IconData(0xe800, fontFamily: 'IconGlobe'), // 1つ目(上)のボタンのアイコン
          secondIconData: IconData(0xe800, fontFamily: 'IconDumbbellAndBarbell'), // 2つ目(下)のボタンのアイコン
          firstWidget: CountryList(), // 1つ目のボタンを押した時に実行されるページのクラス
          secondWidget: SelectBattlePage(), // 2つ目のボタンを押した時に実行されるページのクラス
          firstFontSize: firstFontSize, // 1つ目のボタンのサイズ
          secondFontSize: secondFontSize, // 2つ目のボタンのサイズ
          iconColor: Colors.tealAccent[700], // アイコンボタンの背景色
        ),
      ]
    );
  }
}
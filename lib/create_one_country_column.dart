import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:country_quiz/detail_of_country.dart';

final _rowHeight = 95.0; // 1行の高さ

class CreateOneCountryColumn extends StatelessWidget {  // 国のリストの1列分を作成する

  final String isoCode; // 国のisoCode
  final String name; // 国の名前
  final String flagImagePath; // 国旗の画像パス

  const CreateOneCountryColumn({
    Key key,
    @required this.isoCode,
    @required this.name,
    @required this.flagImagePath,
//    @required this.units,
  }) : assert(isoCode != null),
        assert(name != null),
       assert(flagImagePath != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card( // 1列分の土台となるカード
      shape: RoundedRectangleBorder( // カードの右側を丸める
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(47.5),
            bottomRight: Radius.circular(47.5),
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          )
      ),
      elevation: 2.0, // 高さを2に上げる
      color: Color(0x9FFFFFFF),
      child: Container(
        height: _rowHeight,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding( // 画像に関するウィジェット
                padding: EdgeInsets.only(left: 6.0, right: 3.0),
                child: Container(
//                    height: 100.0,
                  width: 130.0,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Hero( // 画像をクリックした時に滑らかに画像を大きく表示させる所まで移動するようにするためのタグ
                      tag: isoCode,
                      child: Image.asset( // 画像表示
                        flagImagePath,
                      ),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute( // タップされた時に、画像を大きく表示するページに遷移(Heroを用いているので、滑らかに遷移する)
                        builder: (context) => DetailOfCountry(isoCode, flagImagePath))),
                  ),
                ),
              ),
              Flexible( // 国名に関するウィジェット
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text(
                    name,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


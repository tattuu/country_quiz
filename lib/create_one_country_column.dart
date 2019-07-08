import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:country_quiz/detail_of_country.dart';

final _rowHeight = 95.0; // 1行の高さ

class CreateOneCountryColumn extends StatelessWidget {

  final String isoCode;
  final String name;
  final Color color;
  final String flagImagePath;

  const CreateOneCountryColumn({
    Key key,
    @required this.isoCode,
    @required this.name,
    @required this.color,
    @required this.flagImagePath,
//    @required this.units,
  }) : assert(isoCode != null),
        assert(name != null),
       assert(color != null),
       assert(flagImagePath != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(47.5),
            bottomRight: Radius.circular(47.5),
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          )
      ),
      elevation: 2.0,
      color: Color(0x9FFFFFFF),
//      color: Colors.cyan,
      child: Container(
        height: _rowHeight,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6.0, right: 3.0),
                child: Container(
//                    height: 100.0,
                  width: 130.0,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Hero(
                      tag: isoCode,
                      child: Image.asset(
                        flagImagePath,
                      ),
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailOfCountry(isoCode, flagImagePath))),
                  ),
                ),
              ),
              Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                child: Center(
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
//                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:country_quiz/converter_route.dart';
import 'package:country_quiz/unit.dart';

final _rowHeight = 100.0; // 1行の高さ
//final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class CreateOneCountryColumn extends StatelessWidget {

  final String name;
  final ColorSwatch color;
  final String flagImagePath;
  final List<Unit> units;

  const CreateOneCountryColumn({
    Key key,
    @required this.name,
    @required this.color,
    @required this.flagImagePath,
    @required this.units,
  }) : assert(name != null),
       assert(color != null),
       assert(flagImagePath != null),
       assert(units != null),
       super(key: key);

  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return Scaffold(
          body: ConverterRoute(
            color: color,
            name: name,
            units: units,
          ),
        );
      },
    ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
//          borderRadius: _borderRadius,
          highlightColor: color,
          splashColor: Colors.orangeAccent,

          onTap: () => _navigateToConverter(context),

          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Container(
//                    height: 100.0,
                    width: 130.0,
                    alignment: Alignment.center,
                    child: Image.asset(
                      '$flagImagePath',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
//import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/typedefs.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/flutter_tindercard_0.105_fix/flutter_tindercard.dart';

class TrainingPage extends StatefulWidget {

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> with TickerProviderStateMixin {

  List<Country> _countryImageName;
  List<Image> _countryImageWidget = [];
  int _counter = 1;

  @override
  void initState() {
    _countryImageName = countryList.where(acceptAllCountries).toList();
    countryList.forEach((country) {
      _countryImageWidget.add(
        Image.asset(CountryPickerUtils.getFlagImageAssetPath(country.isoCode)),
      );
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
            ..pop()
            ..pop();
      },
      child: Scaffold(
        body: Container(
          child: Column(
  //          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 30,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.17, right: MediaQuery.of(context).size.width / 2.7),
                    child: Text(
                      '$_counter' + '/' + _countryImageName.length.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0),
                    height: MediaQuery.of(context).size.height * 0.78,
                    child: TinderSwapCard(
                      orientation: AmassOrientation.TOP,
                      totalNum: _countryImageName.length,
                      stackNum: 5,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.width * 0.9,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      minHeight: MediaQuery.of(context).size.width * 0.8,
                      countryNames: _countryImageName,
                      countryImageWidgets: _countryImageWidget,
                      cardBuilder: (context, index) => _insideCard(index),
                      swipeCompleteCallback: (CardSwipeOrientation orientation, int index){
                        if(orientation==CardSwipeOrientation.RIGHT || orientation==CardSwipeOrientation.LEFT) {
                          setState(() {
  //                          _countryName = 'セントビンセントおよびグレナディーン諸島';
//                            _countryName = '';
//                            _counter++;
                          });
                        }
//                        if(orientation==CardSwipeOrientation.RIGHT)
////                          print('RIGHT');
//                        else if(orientation==CardSwipeOrientation.LEFT)
//                          print('LEFT');

//                        print(index);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _insideCard(int index) {
    return GestureDetector(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: Colors.grey[200],
        child: Column(
          //                            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 40,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height/ 3,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: _countryImageWidget[index],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                '',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
//      onTapDown: (detail) {
//        setState(() {
//          print(detail);
//          _countryName = _countryImageName[index].jpName;
//        });
//      }
    );
  }
}
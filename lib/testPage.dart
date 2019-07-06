import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:country_quiz/trainingResult.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/country.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/countries.dart';
import 'package:country_quiz/fix_pub_lib/country_pickers_1.1.0_fix/utils/utils.dart';

class TestPage extends StatefulWidget {

  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  final _questionCount = 15;
  var _counter;
  var _percent;
  final double selectButtonPadding = 0;
  final double _selectButtonShape = 30;
  var _winOpacity = 1.0;
  Image _resultFace;
  Set<Country> _oneQuestionMap = Set();
  List<dynamic> _selectButtonContentList;
  Country _questionViewCountry;
  dynamic _questionViewContent;
  List<Country> _knowList = [];
  List<Country> _unKnowList = [];
  bool _questionFormat = true;
  var random;


  void _getQuestionCountry() {
    setState(() {
      _oneQuestionMap.clear();
      _questionFormat = random.nextInt(2) == 0 ? true : false;

      for (int i = 0; i < 4; i++) {
        while(i == _oneQuestionMap.length) {
          _oneQuestionMap.add(countryList[random.nextInt(countryList.length)]);
        }
      }
      _selectButtonContentList = _oneQuestionMap.toList();
      _questionViewCountry = _selectButtonContentList[random.nextInt(_selectButtonContentList.length)];
      if (!_questionFormat) {
        _questionViewContent = Image.asset(CountryPickerUtils.getFlagImageAssetPath(_questionViewCountry.isoCode));

      } else {
        _questionViewContent = Center(
          child: Text(
            _questionViewCountry.jpName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    });

  }

  @override
  void initState() {
    _counter = 0.0;
    _percent = 0.0;
    random = Random.secure();

    _getQuestionCountry();

    super.initState();
  }


  Widget _finDisplay() {

    switch(_knowList.length) {
      case 0: {
        _resultFace = Image.asset('assets/resultFace/0.png');
      }
      break;

      case 1: {
        _resultFace = Image.asset('assets/resultFace/1.png');
      }
      break;

      case 2: {
        _resultFace = Image.asset('assets/resultFace/2.png');
      }
      break;

      case 3: {
        _resultFace = Image.asset('assets/resultFace/3.png');
      }
      break;

      case 4: {
        _resultFace = Image.asset('assets/resultFace/4.png');
      }
      break;

      case 5: {
        _resultFace = Image.asset('assets/resultFace/5.png');
      }
      break;

      case 6: {
        _resultFace = Image.asset('assets/resultFace/6.png');
      }
      break;

      case 7: {
        _resultFace = Image.asset('assets/resultFace/7.png');
      }
      break;

      case 8: {
        _resultFace = Image.asset('assets/resultFace/8.png');
      }
      break;

      case 9: {
        _resultFace = Image.asset('assets/resultFace/9.png');
      }
      break;

      case 10: {
        _resultFace = Image.asset('assets/resultFace/10.png');
      }
      break;

      case 11: {
        _resultFace = Image.asset('assets/resultFace/11.png');
      }
      break;

      case 12: {
        _resultFace = Image.asset('assets/resultFace/12.png');
      }
      break;

      case 13: {
        _resultFace = Image.asset('assets/resultFace/13.png');
      }
      break;

      case 14: {
        _resultFace = Image.asset('assets/resultFace/14.png');
      }
      break;

      case 15: {
        _resultFace = Image.asset('assets/resultFace/15.png');
      }
      break;

      default: {

      }
      break;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Spacer(),
          Text(
            'Fin!',
            style: TextStyle(
              color: Colors.orange,
              fontSize: MediaQuery.of(context).size.width / 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 10,
          ),
          _resultFace,
          Container(
            height: 50,
          ),
          Text(
            '${_knowList.length.toString()}/$_questionCount',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),

        ],
      ),
    );
  }

  void _screenTransition() {
    if (_counter == _questionCount) {
      Timer(Duration(milliseconds: 3500), () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            TrainingResult(
              knowCountryList: _knowList,
              unKnowCountryList: _unKnowList,
            ),
        ));
      });
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          _winOpacity = 0.0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
          ..pop()..pop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Opacity(
              opacity: _winOpacity == 1.0 ? 0.0 : 1.0,
              child: _finDisplay(),
            ),
            Opacity(
              opacity: _winOpacity,
              child: _questionFormat == true ?  _battlePage2(context) : _battlePage1(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressBar(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width - 5,
      margin: EdgeInsets.only(top: 50, bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10),

      child:Container(
        height: 10,
        decoration: BoxDecoration(
//        border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              offset: new Offset(2, 6.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: LinearPercentIndicator(
//        width: MediaQuery.of(context).size.width - 20,
          lineHeight: 20.0,
          percent: _percent,
          progressColor: Colors.greenAccent,
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _questionView(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width ,
      padding: EdgeInsets.all(20),
//      color: Colors.orange,
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        child: Container(
          padding: EdgeInsets.all(10),
          child: _questionViewContent,
        ),
      ),
    );
  }

  Widget _selectButtonBase1(BuildContext context, Country country) {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_counter < _questionCount) {
              _counter++;
              _percent = _counter / _questionCount;
              if (_questionViewCountry.isoCode == country.isoCode) {
                _knowList.add(country);
              } else {
                _unKnowList
                    .add(country);
              }
              if (_counter == _questionCount) {
                _screenTransition();
              }
              if (_counter < _questionCount) {
                _getQuestionCountry();
              }
              print(_counter);
              print(_percent);
            }
          });
        },
        child: Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_selectButtonShape),
          ),
          elevation: 7,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.05,
            height: MediaQuery.of(context).size.height / 11.85,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Text(
                country.jpName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectButtonBase2(BuildContext context, Country country) {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 10, right: 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_counter < _questionCount) {
              _counter++;
              _percent = _counter / _questionCount;
              if (_questionViewCountry.isoCode == country.isoCode) {
                _knowList.add(country);
              } else {
                _unKnowList.add(country);
              }
              _screenTransition();
              _getQuestionCountry();
              print(_counter);
              print(_percent);
            }
          });
        },
        child: Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 5.121,
            width: MediaQuery
                .of(context)
                .size
                .width / 2.3,
            padding: EdgeInsets.all(5),
            child: Image.asset(CountryPickerUtils.getFlagImageAssetPath(country.isoCode)),
          ),
        ),
      ),
    );
  }

  Widget _battlePage1(BuildContext context) {
    return Column(
      children: <Widget>[
        _progressBar(context),
       _questionView(context),
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
//          color: Colors.blue,
          child: Column(
            children: <Widget>[
              _selectButtonBase1(context, _selectButtonContentList[0]),
              _selectButtonBase1(context, _selectButtonContentList[1]),
              _selectButtonBase1(context, _selectButtonContentList[2]),
              _selectButtonBase1(context, _selectButtonContentList[3]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _battlePage2(BuildContext context) {
    return Column(
      children: <Widget>[
        _progressBar(context),
        _questionView(context),
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
//          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _selectButtonBase2(context, _selectButtonContentList[0]),
                  _selectButtonBase2(context, _selectButtonContentList[1]),
                ],
              ),
              Row(
                children: <Widget>[
                  _selectButtonBase2(context, _selectButtonContentList[2]),
                  _selectButtonBase2(context, _selectButtonContentList[3]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
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
  int _counter;
  var _percent;
  final double selectButtonPadding = 0;
  double _selectButtonShape = 30;
  var _winOpacity = 1.0;
  Image _resultFace;
  List<Country> _oneQuestionList = [];
  List<dynamic> _selectButtonContentList;
  Country _questionViewCountry;
  dynamic _questionViewContent;
  List<Country> _knowList = [];
  List<Country> _unKnowList = [];
  bool _questionFormat = true;
  var random;
  double selectButtonTextSize = 20;
  double questionViewPadding = 20;
  double selectButton1FieldHeightSize;
  double selectButton2FieldHeightSize;


  void _getQuestionCountry() {
    setState(() {
      _oneQuestionList.clear();
      _questionFormat = random.nextInt(2) == 0 ? true : false;

      for (int i = 0; i < 4; i++) {
        while(i == _oneQuestionList.length) {
          var keep = countryList(context)[random.nextInt(countryList(context).length)];

          var combineCheck = false;
          _knowList.forEach((country) {
            if (country.name == keep.name) {
              print("b");
              print(keep.name);
              combineCheck = true;
            }
          });
          _unKnowList.forEach((country) {
            if (country.name == keep.name) {
              print("c");
              print(keep.name);
              combineCheck = true;
            }
          });

          _oneQuestionList.forEach((_oneQuestion) {
            if (_oneQuestion.name == keep.name) {
              print("a");
              print(keep.name);
              combineCheck = true;
            }
          });

          if (!combineCheck) {
            _oneQuestionList.add(keep);
          }
        }
      }
      _selectButtonContentList = _oneQuestionList.toList();
      _questionViewCountry = _selectButtonContentList[random.nextInt(_selectButtonContentList.length)];
      if (!_questionFormat) {
        _questionViewContent = Image.asset(CountryPickerUtils.getFlagImageAssetPath(_questionViewCountry.isoCode));

      } else {
        _questionViewContent = Center(
          child: Text(
            _questionViewCountry.name,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    });

  }

  @override
  void initState() {
    _counter = 0;
    _percent = 0.0;
    random = Random.secure();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _getQuestionCountry();
  }

  Widget _finDisplay() {

    switch(_knowList.length) {
      case 0: {
        _resultFace = Image.asset(
            'assets/resultFace/0.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 1: {
        _resultFace = Image.asset(
            'assets/resultFace/1.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 2: {
        _resultFace = Image.asset(
            'assets/resultFace/2.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 3: {
        _resultFace = Image.asset(
            'assets/resultFace/3.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 4: {
        _resultFace = Image.asset(
            'assets/resultFace/4.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 5: {
        _resultFace = Image.asset(
            'assets/resultFace/5.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 6: {
        _resultFace = Image.asset(
            'assets/resultFace/6.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 7: {
        _resultFace = Image.asset(
            'assets/resultFace/7.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 8: {
        _resultFace = Image.asset(
            'assets/resultFace/8.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 9: {
        _resultFace = Image.asset(
            'assets/resultFace/9.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 10: {
        _resultFace = Image.asset(
          'assets/resultFace/10.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 11: {
        _resultFace = Image.asset(
            'assets/resultFace/11.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 12: {
        _resultFace = Image.asset(
          'assets/resultFace/12.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 13: {
        _resultFace = Image.asset(
            'assets/resultFace/13.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 14: {
        _resultFace = Image.asset(
          'assets/resultFace/14.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
      }
      break;

      case 15: {
        _resultFace = Image.asset(
          'assets/resultFace/15.png',
          height: MediaQuery.of(context).size.width / 3,
          fit: BoxFit.fill,
        );
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
              fontSize: MediaQuery.of(context).size.width / 3,
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
          Container(
            alignment: Alignment.center,
            child: Text(
              '${_knowList.length.toString()}/$_questionCount',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),

        ],
      ),
    );
  }

  void _screenTransition() {
    if (_counter == _questionCount) {
      Timer(Duration(milliseconds: 3100), () {
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
    if (MediaQuery.of(context).size.width < 480) {
      _selectButtonShape = 30;
      selectButtonTextSize = 20;
      questionViewPadding = 20;
      selectButton1FieldHeightSize = MediaQuery.of(context).size.height / 11.85;
      selectButton2FieldHeightSize = MediaQuery.of(context).size.height / 5.121;
    } else if (MediaQuery.of(context).size.width < 960) {
      _selectButtonShape = 60;
      selectButtonTextSize = 30;
      questionViewPadding = 40;
      selectButton1FieldHeightSize = MediaQuery.of(context).size.height / 10.5;
      selectButton2FieldHeightSize = MediaQuery.of(context).size.height / 4.83;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
          ..pop()..pop();
      },
      child: SafeArea(
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
      ),
    );
  }

  Widget _progressBar(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width - 5,
      margin: EdgeInsets.only(top: 20, bottom: 10),
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
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(questionViewPadding),
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
              _percent = _counter.toDouble() / _questionCount;
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
            height: selectButton1FieldHeightSize,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: Text(
                country.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: selectButtonTextSize,
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
      padding: EdgeInsets.only(top: 8, left: 2, right: 2),
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_counter < _questionCount) {
              _counter++;
              _percent = _counter.toDouble() / _questionCount;
              if (_questionViewCountry.isoCode == country.isoCode) {
                _knowList.add(country);
              } else {
                _unKnowList.add(country);
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
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
          child: Container(
            height: selectButton2FieldHeightSize,
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
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {

  final double selectButtonPadding = 0;
  final double _selectButtonShape = 30;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
          ..pop()..pop();
      },
      child: Scaffold(
          body: _battlePage2(context),
      ),
//        body:
    );
  }

  Widget _progressBar(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 24),
      height: MediaQuery
          .of(context)
          .size
          .height / 10,
      color: Colors.pinkAccent,
      child: LinearProgressIndicator(
        backgroundColor: Colors.yellowAccent,
      ),
    );
  }

  Widget _questionView(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height / 2.5,
      padding: EdgeInsets.all(20),
      color: Colors.orange,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(),
      ),
    );
  }

  Widget _selectButtonBase1(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: selectButtonPadding, right: selectButtonPadding),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_selectButtonShape),
        ),
        elevation: 5,
        child: Container(
          height: 50,
        ),
      ),
    );
  }

  Widget _selectButtonBase2(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 5,
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
      padding: EdgeInsets.all(3),
      color: Colors.lightGreenAccent,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(),
      ),
    );
  }

  Widget _battlePage1(BuildContext context) {
    return Column(
      children: <Widget>[
        _progressBar(context),
       _questionView(context),
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              _selectButtonBase1(context),
              _selectButtonBase1(context),
              _selectButtonBase1(context),
              _selectButtonBase1(context),
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
          height: MediaQuery.of(context).size.height / 2.5,
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _selectButtonBase2(context),
                  _selectButtonBase2(context),
                ],
              ),
              Row(
                children: <Widget>[
                  _selectButtonBase2(context),
                  _selectButtonBase2(context),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'package:country_quiz/country_list_route.dart';

class TopPage extends StatelessWidget {

  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return CountryListRoute();
      },
    ));
  }

  Widget _iconLogo(BuildContext context, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(75.0),
      child: Container(
        height: 150,
        width: 150,
        color: Colors.tealAccent[700],
        child: FlatButton(
          onPressed: () => _navigateToConverter(context),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconName(BuildContext context, String name) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Country Quiz',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Spacer(flex: 10),
            _iconLogo(context, IconData(0xe800, fontFamily: 'Icon')),
            Spacer(),
            _iconName(context, 'List'),
            Spacer(flex: 15),
            _iconLogo(context, Icons.gamepad),
            Spacer(),
            _iconName(context, 'Test'),
            Spacer(flex: 10),
          ],
        ),
      ),
    );
  }
}

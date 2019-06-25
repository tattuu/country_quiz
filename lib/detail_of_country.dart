import 'package:flutter/material.dart';

class DetailOfCountry extends StatelessWidget {
  final String name;
  final String flagImagePath;

  DetailOfCountry(this.name, this.flagImagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.blueGrey[50],
      backgroundColor: Colors.grey[300],
//      backgroundColor: Color(0xEFDFDFDF),
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Center(
            child: Hero(
              tag: name,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  flagImagePath,
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
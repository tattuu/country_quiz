import 'package:flutter/material.dart';

class CopyrightAttributionPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Spacer(),
              Text(
                'CopyrightAttributionPageForIcon',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Spacer(),
              Text(
                'Streamline Emoji is a free collection of cute emoji, \nstarted as a part of Streamline UX.\n Made by @webalys under \nthe Creative Common Attribution licence',
              ),
              Spacer(),
              Text(
                'Icon made by Freepik from www.flaticon.com',
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
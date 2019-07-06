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
              Text('使用したアイコンなどについてのCopyrightAttributionPage'),
              Spacer(),
              Text(
                'Streamline Emoji is a free collection of cute emoji, started as a part of Streamline UX. Made by @webalys under the Creative Common Attribution licence',
                style: TextStyle(
  //                fontSize: 20,
                )
              ),
              Spacer(),
              Text(
                'Icon made by Freepik from www.flaticon.com',
                style: TextStyle(
  //                fontSize: 20,
                )
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
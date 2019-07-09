import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyrightAttributionPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
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
                InkWell(
                  child: Text( 'Streamline Emoji is a free collection of cute emoji, \nstarted as a part of Streamline UX.\n Made by @webalys under \nthe Creative Common Attribution licence',),
                  onTap: () async {
                    if (await canLaunch("url")) {
                      await launch("url");
                    }
                  },
                ),
                Spacer(),
                InkWell(
                  child: Text('Icon made by Freepik from www.flaticon.com'),
                  onTap: () async {
                    if (await canLaunch("")) {
                      await launch("url");
                    }
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

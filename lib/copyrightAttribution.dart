import 'package:flutter/gestures.dart';
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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Streamline Emoji is a free collection of cute emoji, \nstarted as a part of ',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: 'Streamline UX',
                        style: TextStyle(color: Colors.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.streamlineicons.com/ux/');
                          },
                      ),
                      TextSpan(
                        text: '.\n Made by ',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: '@webalys',
                        style: TextStyle(color: Colors.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://twitter.com/webalys');
                          },
                      ),
                      TextSpan(
                        text: ' under \nthe ',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: 'Creative Common Attribution',
                        style: TextStyle(color: Colors.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://creativecommons.org/licenses/by/4.0/');
                          },
                      ),
                      TextSpan(
                        text: 'licence',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Icon made by',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: ' Freepik',
                        style: TextStyle(color: Colors.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.freepik.com/');
                          },
                      ),
                      TextSpan(
                        text: ' form ',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextSpan(
                        text: 'www.flaticon.com',
                        style: TextStyle(color: Colors.lightBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://www.flaticon.com/');
                          },
                      ),
                    ],
                  ),
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

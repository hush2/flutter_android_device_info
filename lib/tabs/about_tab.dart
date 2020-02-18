// (c) 2019 hush2. https://github.com/hush2

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/hush2.png',
          width: 128,
        ),
        Column(children: <Widget>[
          Text('Author: Muhammad Ayoub Khan'),
          Text(''),
        ],),
        RaisedButton(
          color: Colors.indigo,
          child: Text('Visit my Site',
              style: TextStyle(fontSize: 12, color: Colors.white)),
          onPressed: () {
            launch('https://ayoubkhan.netlify.com');
          },
        ),
      ],
    );
  }
}

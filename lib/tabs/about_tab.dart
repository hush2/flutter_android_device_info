import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/hush2_512.png',
          width: 128,
        ),
        RaisedButton(
          color: Colors.lightBlue,
          child: Text('GO TO GITHUB',
              style: TextStyle(fontSize: 12, color: Colors.white)),
          onPressed: () {
            launch('https://github.com/hush2');
          },
        ),
      ],
    );
  }
}

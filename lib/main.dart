import 'package:flutter/material.dart';

import 'tabs/about_tab.dart';
import 'tabs/device_tab.dart';
import 'tabs/system_tab.dart';
import 'tabs/battery_tab.dart';
import 'tabs/sensors_tab.dart';
import 'tabs/network_tab.dart';

const appTitle = 'Device Info';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Home(title: appTitle),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.android,
                  color: Colors.lightGreenAccent,
                ),
              ),
              Text(widget.title),
            ],
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.lightGreenAccent,
          tabs: [
            Tab(icon: Icon(Icons.memory), text: 'System'),
            Tab(icon: Icon(Icons.phone_android), text: 'Device'),
            Tab(icon: Icon(Icons.battery_unknown), text: 'Battery'),
            Tab(icon: Icon(Icons.wifi), text: 'Network'),
            Tab(icon: Icon(Icons.screen_rotation), text: 'Sensors'),
            Tab(icon: Icon(Icons.info), text: 'About'),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: TabBarView(
          children: [
            SystemTab(),
            DeviceTab(),
            BatteryTab(),
            NetworkTab(),
            SensorsTab(),
            AboutTab(),
          ],
        ),
      ),
    );
  }
}

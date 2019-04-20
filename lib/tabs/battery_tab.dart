import 'package:flutter/material.dart';
import 'package:android_device_info/android_device_info.dart';

import '../widgets/row_item.dart';

class BatteryTab extends StatefulWidget {
  @override
  _BatteryTabState createState() => _BatteryTabState();
}

class _BatteryTabState extends State<BatteryTab> {
  var data = {};

  @override
  void initState() {
    super.initState();

    AndroidDeviceInfo().getBatteryInfo().then((data) {
      if (mounted) {
        setState(() {
          this.data = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(),
          RowItem('Charge Level', '${data['batteryPercentage']}%'),
          RowItem('Health', data['batteryHealth']),
          RowItem('is Charging', '${data['isDeviceCharging']}'),
          RowItem('Source', '${data['chargingSource']}'),
          RowItem('Technology', data['batteryTechnology']),
          RowItem('Temperature', '${data['batteryTemperature']}°c'),
          RowItem('Voltage', '${data['batteryVoltage']}'),
//        RowItem('isBatteryPresent', '${data['isBatteryPresent']}'),
          Divider(),
        ],
      ),
    );
  }
}

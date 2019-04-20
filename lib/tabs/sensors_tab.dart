import 'package:flutter/material.dart';
import 'package:android_device_info/android_device_info.dart';

import '../widgets/row_item.dart';

class SensorsTab extends StatefulWidget {
  @override
  _SensorsTabState createState() => _SensorsTabState();
}

class _SensorsTabState extends State<SensorsTab> {
  var data = [];

  @override
  void initState() {
    super.initState();

    AndroidDeviceInfo().getSensorInfo().then((data) {
      if (mounted) {
        setState(() {
          this.data = data;
        });
      }
    });
  }

  List<Widget> sensors() {
    var sensors = data.map<Widget>((item) {
      return Column(
        children: <Widget>[
          Divider(),
          RowItem('Model', item['name']),
          RowItem('Manufacturer', item['vendor']),
          RowItem('Version', '${item['version']}'),
          RowItem('Power', '${item['power'].toStringAsFixed(3)} mA'),
          RowItem(
            'Resolution',
            '${item['resolution'].toStringAsFixed(6)} m/s²',
          ),
          RowItem(
            'Maximum Range',
            '${item['maximumRange'].toStringAsFixed(6)} m/s²',
          ),
        ],
      );
    }).toList();
    sensors.add(Divider());
    return sensors;
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Column(children: sensors()),
    );
  }
}

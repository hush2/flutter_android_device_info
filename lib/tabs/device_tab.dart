// (c) 2019 hush2. https://github.com/hush2

import 'package:flutter/material.dart';
import 'package:android_device_info/android_device_info.dart';

import '../widgets/row_item.dart';

const memoryUnit = 'MB';

class DeviceTab extends StatefulWidget {
  @override
  _DeviceTabState createState() => _DeviceTabState();
}

class _DeviceTabState extends State<DeviceTab> {
  var data = {};

  getData() async {
    var data = {};

    final memory = await AndroidDeviceInfo().getMemoryInfo(unit: memoryUnit);
    final display = await AndroidDeviceInfo().getDisplayInfo();
    final fp = await AndroidDeviceInfo().getFingeprintInfo();

    data.addAll(memory);
    data.addAll(display);
    data.addAll(fp);

    if (mounted) {
      setState(() {
        this.data = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final totalRam = data['totalRAM'].round();
    final totalExternalMemorySize = data['totalExternalMemorySize'].round();
    final totalInternalMemorySize = data['totalInternalMemorySize'].round();
    final availableExternalMemorySize =
        data['availableExternalMemorySize'].round();
    final availableInternalMemorySize =
        data['availableInternalMemorySize'].round();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(),
          RowItem('Display Resolution', data['resolution']),
          RowItem('Density', data['density']),
          RowItem(
            'RefreshRate',
            data['refreshRate'].toStringAsFixed(2) + ' Hz',
          ),
          RowItem(
            'Physical Size',
            data['physicalSize'].toStringAsFixed(2) + ' in',
          ),
          Divider(),
          RowItem('Total RAM', '$totalRam $memoryUnit'),
          RowItem(
            'Total Internal Memory',
            '$totalInternalMemorySize $memoryUnit',
          ),
          RowItem(
            'Available Internal Memory',
            '$availableInternalMemorySize $memoryUnit',
          ),
          RowItem(
            'Total External Storage',
            '$totalExternalMemorySize $memoryUnit',
          ),
          RowItem('Available External Storage',
              '$availableExternalMemorySize $memoryUnit'),
          Divider(),
          RowItem(
              'Fingerprint Sensor', '${data['isFingerprintSensorPresent']}'),
          RowItem('Fingerprints Enrolled', '${data['areFingerprintsEnrolled']}')
        ],
      ),
    );
  }
}

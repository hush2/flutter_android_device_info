import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_device_info/android_device_info.dart';

import '../widgets/row_item.dart';

class NetworkTab extends StatefulWidget {
  @override
  _NetworkTabState createState() => _NetworkTabState();
}

class _NetworkTabState extends State<NetworkTab> {
  var data = {};

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    var data = {};

    final memory = await AndroidDeviceInfo().getNetworkInfo();
    final display = await AndroidDeviceInfo().getNfcInfo();
    var sim = await AndroidDeviceInfo().getSimInfo();

    data.addAll(memory);
    data.addAll(display);
    data.addAll(sim);

    if (mounted) {
      setState(() {
        this.data = data;
      });
    }

    var permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (permission == PermissionStatus.denied) {
      var permissions =
          await PermissionHandler().requestPermissions([PermissionGroup.phone]);
      if (permissions[PermissionGroup.phone] == PermissionStatus.granted) {
        sim = await AndroidDeviceInfo().getSimInfo();
        data.addAll(sim);
        if (mounted) {
          setState(() {
            this.data = data;
          });
        }
      }
    }
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
          RowItem('Network Available', '${data['isNetworkAvailable']}'),
          RowItem('Network', '${data['networkType']}'),
          RowItem('iPv4 Address', '${data['iPv4Address']}'),
          RowItem('iPv6 Address', '${data['iPv6Address']}'),
          RowItem('WiFi Enabled', '${data['isWifiEnabled']}'),
          RowItem('WiFi SSID', '${data['wifiSSID']}'),
          RowItem('WiFi BSSID', '${data['wifiBSSID']}'),
          RowItem('WiFi Speed', '${data['wifiLinkSpeed']}'),
          RowItem('WiFi MAC', '${data['wifiMAC']}'),
          Divider(),
          RowItem('NFC Present', '${data['isNfcPresent']}'),
          RowItem('NFC Enabled', '${data['isNfcEnabled']}'),
          Divider(),
          RowItem('IMSI', '${data['imsi']}'),
          RowItem('Serial', '${data['serial']}'),
          RowItem('Country', '${data['country']}'),
          RowItem('Carrier', '${data['carrier']}'),
          RowItem('SIM Locked', '${data['isSimNetworkLocked']}'),
//          RowItem('activeMultiSimInfo', '${data['activeMultiSimInfo']}'),
          RowItem('Multi SIM', '${data['isMultiSim']}'),
          RowItem('Active SIM(s)', '${data['numberOfActiveSim']}'),
          Divider(),
        ],
      ),
    );
  }
}

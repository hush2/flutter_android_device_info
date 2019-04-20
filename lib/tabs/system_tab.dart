// (c) 2019 hush2. https://github.com/hush2

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_device_info/android_device_info.dart';

import '../widgets/row_item.dart';

class SystemTab extends StatefulWidget {
  @override
  _SystemTabState createState() => _SystemTabState();
}

class _SystemTabState extends State<SystemTab> {
  var data = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var data = await AndroidDeviceInfo().getSystemInfo();

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
        data = await AndroidDeviceInfo().getSystemInfo();
        data.addAll(data);
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

    final date = DateTime.fromMillisecondsSinceEpoch(data['buildTime']);
    final format = DateFormat('mm/dd/yyyy');
    final buildTime = format.format(date);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(),
          RowItem('Model', data['model']),
          RowItem('Product', data['product']),
          RowItem('Board', data['board']),
          RowItem('Manufacturer', data['manufacturer']),
          RowItem('Device', data['device']),
          RowItem('Hardware', data['hardware']),
          RowItem('Device Type', data['deviceType']),
          RowItem('Phone Type', data['phoneType']),
          RowItem('Phone Number', data['phoneNo']),
          RowItem('Orientation', data['orientation']),
          RowItem('Screen Display ID', data['screenDisplayID']),
          Divider(),
          RowItem('Android Version', data['osVersion']),
          RowItem('Codename', data['osCodename']),
          RowItem('SDK Verson', data['buildVersionSDK'].toString()),
          RowItem('Build Codename', data['buildVersionCodename']),
          Divider(),
          RowItem('Radio Version', data['radioVer']),
          RowItem('Bootloader', data['bootloader']),
          RowItem('fingerprint', data['fingerprint']),
          RowItem('Is Rooted?', data['isDeviceRooted'].toString()),
          Divider(),
          RowItem('Build Brand', data['buildBrand']),
          RowItem('Build Host', data['buildHost']),
          RowItem('Build Tags', data['buildTags']),
          RowItem('Build Time', buildTime),
          RowItem('Build Version Incremental', data['buildVersionIncremental']),
          RowItem('Build User', data['buildUser']),
          RowItem('Build Version Release', data['buildVersionRelease']),
          Divider(),
        ],
      ),
    );
  }
}

import 'package:coldstore/Screens/AddRecord.dart';
import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

// iOS only: Localized labels language setting is equal to CFBundleDevelopmentRegion value (Info.plist) of the iOS project
// Set iOSLocalizedLabels=false if you always want english labels whatever is the CFBundleDevelopmentRegion value.
const iOSLocalizedLabels = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  //
  // Future<void> _askPermissions() async {
  //   PermissionStatus permissionStatus = await _getContactPermission();
  //   if (permissionStatus != PermissionStatus.granted) {
  //     _handleInvalidPermissions(permissionStatus);
  //   }
  // }
  //
  // Future<PermissionStatus> _getContactPermission() async {
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.contacts);
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.disabled) {
  //     Map<PermissionGroup, PermissionStatus> permissionStatus =
  //     await PermissionHandler()
  //         .requestPermissions([PermissionGroup.contacts]);
  //     return permissionStatus[PermissionGroup.contacts] ??
  //         PermissionStatus.unknown;
  //   } else {
  //     return permission;
  //   }
  // }
  //
  // void _handleInvalidPermissions(PermissionStatus permissionStatus) {
  //   if (permissionStatus == PermissionStatus.denied) {
  //     throw PlatformException(
  //         code: "PERMISSION_DENIED",
  //         message: "Access to Contact  data denied",
  //         details: null);
  //   } else if (permissionStatus == PermissionStatus.disabled) {
  //     throw PlatformException(
  //         code: "PERMISSION_DISABLED",
  //         message: "Contact data is not available on device",
  //         details: null);
  //   }
  // }
  //


  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts Plugin Example')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: const Text('Select Contact'),
              onPressed: () =>  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddRecord())) ,
            ),
            RaisedButton(
              child: const Text('Native Contacts picker'),
              onPressed: () =>null
                  ,
            ),
          ],
        ),
      ),
    );
  }
}
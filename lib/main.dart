import 'package:coldstore/Screens/AddRecord.dart';
import 'package:coldstore/Screens/showRecords.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
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



  Future<void> _askPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
  }




  @override
  void initState() {
    super.initState();
    _askPermissions();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts Plugin Example')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: const Text('Add Record'),
              onPressed: () =>  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddRecord())) ,
            ),
            RaisedButton(
              child: const Text('See Record'),
              onPressed: () =>Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShowRecords())),
            ),
          ],
        ),
      ),
    );
  }
}
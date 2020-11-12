import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  String userId = '';
  BuildContext cont;
  int _typeSelected1 , _sizeSelected,roomSelected,rackSelected,positionSelected,
      levelSelected,directionSelected ;
  Contact _contact;
  List<DropdownMenuItem<int>> typeList = [];
  List<DropdownMenuItem<int>> roomList = [];
  List<DropdownMenuItem<int>> rackList = [];
  List<DropdownMenuItem<int>> positionList = [];
  List<DropdownMenuItem<int>> levelList = [];
  List<DropdownMenuItem<int>> directionList = [];
  List<String> stringPotatoTypeListList = ['Seed', 'Rashan'];
  List<String> stringRoomTypeListList = ['Room 1', 'Room 2','Room 3'];
  List<String> stringRacksTypeListList = ['Rack 1', 'Rack 2','Rack 3'];
  List<String> stringPositionTypeListList = ['Front', 'Back','Middle'];
  List<String> stringLevelTypeListList = ['G', '1','2','3','4'];
  List<String> stringDirectionTypeListList = ['Left', 'Right'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<int>> potatoSizeList = [];
  List<String> stringPotatoList = [
    'Size1',
    'Size2',
  ];
  final _noOfBori = TextEditingController();
  final _noOfTora = TextEditingController();


  loadQuestions() {
    typeList = [];
    int index = 0;
    for (var text in stringPotatoTypeListList) {
      typeList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }
    index = 0;
    for (var text in stringPotatoList) {
      potatoSizeList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }
    index = 0;
    for (var text in stringRoomTypeListList) {
      roomList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }
    index = 0;
    for (var text in stringPositionTypeListList) {
      positionList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }
    index = 0;
    for (var text in stringRacksTypeListList) {
      rackList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }
    index = 0;
    for (var text in stringDirectionTypeListList) {
      directionList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }
    index = 0;
    for (var text in stringLevelTypeListList) {
      levelList.add(
        new DropdownMenuItem(
          value: index,
          child: new Text(
            text,
            textAlign: TextAlign.left,
            // style: GoogleFonts.poppins(
            //     color: darkGreyColor,
            //     fontWeight: FontWeight.w300,
            //     fontSize: 1.6 * SizeConfig.textMultiplier),
          ),
        ),
      );
      index++;
    }

  }

  @override
  void initState() {
    super.initState();
    loadQuestions();
    _pickContact();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   // user = Provider.of<User>(cont, listen: false);
    //   // checkAuthentication();
    // });
  }


  Future<void> _pickContact() async {
    try {
      final Contact contact = await ContactsService.openDeviceContactPicker(
          iOSLocalizedLabels: false);
      setState(() {
        _contact = contact;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts Plugin Example')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (_contact != null)
                  Text('Contact selected: ${_contact.phones.toList()[0].value}'),
                if (_contact != null)
                  Text('Contact selected: ${_contact.givenName}'),
                DropdownButtonFormField(
                  hint: Text('Select Type'),
                  dropdownColor: Colors.white,
                  items: typeList,
                  value: _typeSelected1,
                  onChanged: (value) {
                    setState(() {
                      _typeSelected1 = value;
                    });
                  },
                  isExpanded: true,
                ),
                DropdownButtonFormField(
                  hint: Text('Select Size'),
                  dropdownColor: Colors.white,
                  items: potatoSizeList,
                  value: _sizeSelected,
                  onChanged: (value) {
                    setState(() {
                      _sizeSelected = value;
                    });
                  },
                  isExpanded: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2-4,
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: _noOfBori,
                        // style: GoogleFonts.poppins(
                        //     color: darkGreyColor,
                        //     fontSize: 1.8 * SizeConfig.textMultiplier),
                        validator: (String name) {
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'No. of Bori',
                            // errorText: _validate1 ? getTranslated(context, 'enter_ans') : null,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2-4,
                      child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: _noOfTora,
                        // style: GoogleFonts.poppins(
                        //     color: darkGreyColor,
                        //     fontSize: 1.8 * SizeConfig.textMultiplier),
                        validator: (String name) {
                          // if (name == '')
                          //   return getTranslated(context, 'no_first_ans');
                          // else
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'No. of Tora',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            )),
                      ),
                    ),
                  ],

                ),
                DropdownButtonFormField(
                  hint: Text('Select Room'),
                  dropdownColor: Colors.white,
                  items: roomList,
                  value: roomSelected,
                  onChanged: (value) {
                    setState(() {
                      roomSelected = value;
                    });
                  },
                  isExpanded: true,
                ),
                DropdownButtonFormField(
                  hint: Text('Select Racks'),
                  dropdownColor: Colors.white,
                  items: rackList,
                  value: rackSelected,
                  onChanged: (value) {
                    setState(() {
                      rackSelected = value;
                    });
                  },
                  isExpanded: true,
                ),
                DropdownButtonFormField(
                  hint: Text('Select Direction'),
                  dropdownColor: Colors.white,
                  items: directionList,
                  value: directionSelected,
                  onChanged: (value) {
                    setState(() {
                      directionSelected = value;
                    });
                  },
                  isExpanded: true,
                ),
                DropdownButtonFormField(
                  hint: Text('Select Position'),
                  dropdownColor: Colors.white,
                  items: positionList,
                  value: positionSelected,
                  onChanged: (value) {
                    setState(() {
                      positionSelected = value;
                    });
                  },
                  isExpanded: true,
                ),
                DropdownButtonFormField(
                  hint: Text('Select Height'),
                  dropdownColor: Colors.white,
                  items: levelList,
                  value: levelSelected,
                  onChanged: (value) {
                    setState(() {
                      levelSelected = value;
                    });
                  },
                  isExpanded: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

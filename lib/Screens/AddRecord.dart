import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:coldstore/Service/DatabaseService.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  String userId = '';
  BuildContext cont;
  int typeSelected,
      sizeSelected,
      roomSelected,
      rackSelected,
      positionSelected,
      levelSelected,
      directionSelected;

  Contact _contact;
  List<DropdownMenuItem<int>> typeList = [];
  List<DropdownMenuItem<int>> roomList = [];
  List<DropdownMenuItem<int>> rackList = [];
  List<DropdownMenuItem<int>> positionList = [];
  List<DropdownMenuItem<int>> levelList = [];
  List<DropdownMenuItem<int>> directionList = [];
  List<String> stringPotatoTypeListList = ['Seed', 'Rashan'];
  List<String> stringRoomTypeListList = ['Room 1', 'Room 2', 'Room 3'];
  List<String> stringRacksTypeListList = ['Rack 1', 'Rack 2', 'Rack 3'];
  List<String> stringPositionTypeListList = ['Front', 'Back', 'Middle'];
  List<String> stringLevelTypeListList = ['G', '1', '2', '3', '4'];
  List<String> stringDirectionTypeListList = ['Left', 'Right'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<int>> potatoSizeList = [];
  List<String> stringPotatoList = [
    'Size1',
    'Size2',
  ];
  final _noOfBori = TextEditingController();
  final _markers = TextEditingController();
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _contact != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Name : ${_contact.displayName}',
                            style: TextStyle(fontSize: 24),
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.contact_phone,
                            color: Color.fromRGBO(191, 144, 0, 1),
                          ),
                          onPressed: _pickContact),
                  if (_contact != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Contact :${_contact.phones.toList()[0].value}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  Row(
                    children: [
                      Flexible(
                          child: TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _markers,
                        validator: (String name) {
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Marker',
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
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      hint: Text('Select Type'),
                      dropdownColor: Colors.white,
                      items: typeList,
                      value: typeSelected,
                      onChanged: (value) {
                        setState(() {
                          typeSelected = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      hint: Text('Select Size'),
                      dropdownColor: Colors.white,
                      items: potatoSizeList,
                      value: sizeSelected,
                      onChanged: (value) {
                        setState(() {
                          sizeSelected = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: TextFormField(
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          controller: _noOfBori,
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
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          controller: _noOfTora,
                          validator: (String name) {
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
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setTransactionFromValue();
                        },
                        color: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        child: Text(
                          'Add To Record',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setTransactionFromValue() {
    if (_contact == null) {
      showDialog(
          context: context,
          builder: (context) =>
              ErrorDialog('No Contact Selected', 'Please Select a contact'));
    } else if (typeSelected == null) {
      showDialog(
          context: context,
          builder: (context) =>
              ErrorDialog('No Type Selected', 'Please Select a Potato Type'));
    } else if (positionSelected == null) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              'No Position Selected', 'Please Select a Position in Rack'));
    } else if (directionSelected == null) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              'No Direction Selected', 'Please Select a direction in Rack'));
    } else if (rackSelected == null) {
      showDialog(
          context: context,
          builder: (context) =>
              ErrorDialog('No Rack Selected', 'Please Select a Rack to store'));
    } else if (roomSelected == null) {
      showDialog(
          context: context,
          builder: (context) =>
              ErrorDialog('No Room Selected', 'Please Select a Room to store'));
    } else if (levelSelected == null) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              'No Height Selected', 'Please Select a Level to rack'));
    } else if (_noOfTora.text == '' && _noOfBori.text == '') {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
              'No Input Selected', 'Please input number of Tora or Bori'));
    } else {
      ColdStoreTransaction currentTransaction = ColdStoreTransaction(
          contactName: _contact.displayName,
          contactNumber: _contact.phones.toList()[0].value,
          currentDate: DateTime.now(),
          direction: directionList[directionSelected]
              .child
              .toString()
              .split('"')
              .toList()[1],
          height:
              levelList[levelSelected].child.toString().split('"').toList()[1],
          position: positionList[positionSelected]
              .child
              .toString()
              .split('"')
              .toList()[1],
          rack: rackList[rackSelected].child.toString().split('"').toList()[1],
          room: roomList[roomSelected].child.toString().split('"').toList()[1],
          sizeOfPotato: potatoSizeList[sizeSelected]
              .child
              .toString()
              .split('"')
              .toList()[1],
          typeOfPotato:
              typeList[typeSelected].child.toString().split('"').toList()[1],
          marker: _markers.text,
          noOfTora: _noOfTora.text,
          noOfBori: _noOfBori.text,
          remainingBori: _noOfBori.text,
          remainingTora: _noOfTora.text,
          transactionId: Uuid().v4());
      DatabaseService database = DatabaseService();
      database.setFuelTransactionData(currentTransaction);
      Navigator.pop(context);
    }
  }
}

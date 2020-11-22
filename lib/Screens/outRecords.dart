import 'dart:async';

import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:coldstore/Service/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OutRecord extends StatefulWidget {
  final ColdStoreInTransaction currentTransaction;

  OutRecord(this.currentTransaction);

  @override
  _OutRecordState createState() => _OutRecordState();
}

class _OutRecordState extends State<OutRecord> {
  List<DropdownMenuItem<int>> boriList = [];
  int boriSelected;
  List<DropdownMenuItem<int>> toraList = [];
  int toraSelected;
  DatabaseService database = DatabaseService();

  @override
  void initState() {
    super.initState();
    setValues();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contacts Plugin Example')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (toraSelected == null && boriSelected == null) {
              showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(
                      'No Change Selected', 'Please Select Change in Rack'));
            } else {
              ColdStoreOutTransaction outTransaction = ColdStoreOutTransaction(
                  transactionId: Uuid().v4(),
                  currentDate: DateTime.now(),
                  boriAfter:boriSelected != null? boriList[boriSelected]
                      .child
                      .toString()
                      .split('"')
                      .toList()[1]:widget.currentTransaction.remainingBori,
                  toraAfter: toraSelected!=null?toraList[toraSelected]
                      .child
                      .toString()
                      .split('"')
                      .toList()[1]: widget.currentTransaction.remainingTora,
                  boriBefore: widget.currentTransaction.remainingBori,
                  toraBefore: widget.currentTransaction.remainingTora,
                  inTransactionId: widget.currentTransaction.transactionId);
              if(toraSelected!=null)
              widget.currentTransaction.remainingTora = toraList[toraSelected]
                  .child
                  .toString()
                  .split('"')
                  .toList()[1];
              if(boriSelected!=null)
                widget.currentTransaction.remainingBori = boriList[boriSelected]
                  .child
                  .toString()
                  .split('"')
                  .toList()[1];
              database.setInTransactionData(widget.currentTransaction);
              database.setOutTransactionData(outTransaction);

              Navigator.pop(context);
            }
          },
          child: Icon(
            Icons.save,
            size: 30,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          heroTag: 'Update Record',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyMainCard(widget.currentTransaction),
              ],
            ),
          ),
        ));
  }

  MyMainCard(ColdStoreInTransaction currentTransaction) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        currentTransaction.contactName,
                        textScaleFactor: 1.5,
                      ),
                      Text(
                        currentTransaction.contactNumber,
                        textScaleFactor: 1.5,
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                if (currentTransaction.remainingTora != '' &&
                    currentTransaction.remainingTora != '0')
                  Column(
                    children: [
                      Text(
                        'Tora',
                        textScaleFactor: 1.2,
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Before ',
                              textScaleFactor: 1.2,
                            ),
                            Text(
                              '${currentTransaction.remainingTora}',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'After',
                              textScaleFactor: 1.2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (currentTransaction.remainingTora != '' &&
                    currentTransaction.remainingTora != '0')
                  DropdownButtonFormField(
                    hint: Text('Select Tora After Take out'),
                    dropdownColor: Colors.white,
                    items: toraList,
                    value: toraSelected,
                    onChanged: (value) {
                      setState(() {
                        toraSelected = value;
                      });
                    },
                    isExpanded: true,
                  ),
                if (currentTransaction.remainingBori != '' &&
                    currentTransaction.remainingBori != '0')
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Bori',
                        textScaleFactor: 1.2,
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Before ',
                              textScaleFactor: 1.2,
                            ),
                            Text(
                              '${currentTransaction.remainingBori}',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'After',
                              textScaleFactor: 1.2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (currentTransaction.remainingBori != '' &&
                    currentTransaction.remainingBori != '0')
                  DropdownButtonFormField(
                    hint: Text('Select Bori After Take out'),
                    dropdownColor: Colors.white,
                    items: boriList,
                    value: boriSelected,
                    onChanged: (value) {
                      setState(() {
                        boriSelected = value;
                      });
                    },
                    isExpanded: true,
                  ),
                if (currentTransaction.marker != '')
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Marker',
                              textScaleFactor: 1.5,
                            ),
                            Text(
                              '${currentTransaction.marker}',
                              textScaleFactor: 1.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )),
    );
  }


  void setValues() {
    boriList = List.generate(
      int.parse(widget.currentTransaction.remainingBori),
      (index) => new DropdownMenuItem(
        value: index,
        child: new Text(
          index.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
    toraList = List.generate(
      int.parse(widget.currentTransaction.remainingTora),
      (index) => new DropdownMenuItem(
        value: index,
        child: new Text(
          index.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}

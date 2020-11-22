import 'dart:async';

import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:coldstore/Screens/outRecords.dart';
import 'package:coldstore/Service/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordDetails extends StatefulWidget {
  final ColdStoreInTransaction currentTransaction;

  RecordDetails(this.currentTransaction);

  @override
  _RecordDetailsState createState() => _RecordDetailsState();
}

class _RecordDetailsState extends State<RecordDetails> {
  ColdStoreInTransaction inTransaction;
  List<ColdStoreOutTransaction> outTransactions = [];
  DatabaseService database = DatabaseService();

  @override
  void initState() {
    super.initState();
    inTransaction = widget.currentTransaction;
    getOutDetails(widget.currentTransaction);
    getCurrentTransactionDetails();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contacts Plugin Example')),
        floatingActionButton: Visibility(
          visible: !((inTransaction.remainingTora=='0'||inTransaction.remainingTora=='')
              &&(inTransaction.remainingBori=='' ||inTransaction.remainingBori=='0')),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OutRecord(inTransaction)));
            },
            child: Icon(
              Icons.edit_outlined,
              size: 30,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            heroTag: 'Update Record',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                MyMainCard(inTransaction),
                if(outTransactions.isNotEmpty)
                Column(
                  children: [
                    Text("Out Records",textScaleFactor: 2,),
                    Column(
                      children: outTransactions.map((e) => MyOutCard(e)).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }


  Widget MyOutCard(ColdStoreOutTransaction currentTransaction) {
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
                if (currentTransaction.toraBefore != currentTransaction.toraAfter)
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
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Before ',
                              textScaleFactor: 1.2,
                            ),
                            Text(
                              '${currentTransaction.toraBefore}',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [
                            Text(
                              'After',
                              textScaleFactor: 1.2,
                            ),Text(
                              '${currentTransaction.toraAfter}',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (currentTransaction.boriBefore != currentTransaction.boriAfter)
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
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Before ',
                              textScaleFactor: 1.2,
                            ),
                            Text(
                              '${currentTransaction.boriBefore}',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [
                            Text(
                              'After',
                              textScaleFactor: 1.2,
                            ),Text(
                              '${currentTransaction.boriAfter}',
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                      Text('Date'),
                      Text(
                        DateFormat('dd-MM-yyyy    hh:mm a')
                            .format(currentTransaction.currentDate),
                        textScaleFactor: 1.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total',
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        'Stored',
                        textScaleFactor: 1.2,
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
                if (currentTransaction.noOfTora != '')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${currentTransaction.noOfTora}',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Text(
                          'Tora',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          '${currentTransaction.remainingTora}',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                if (currentTransaction.noOfBori != '')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${currentTransaction.noOfBori}',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Text(
                          'Bori',
                          textScaleFactor: 1.2,
                        ),
                        Text(
                          '${currentTransaction.remainingBori}',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
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
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
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
                        'Room',
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        '${widget.currentTransaction.room}',
                        textScaleFactor: 1.2,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Level',
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        '${widget.currentTransaction.height}',
                        textScaleFactor: 1.2,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Rack',
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        '${widget.currentTransaction.rack}',
                        textScaleFactor: 1.2,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Direction',
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        '${widget.currentTransaction.direction}',
                        textScaleFactor: 1.2,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Date'),
                      Text(
                        DateFormat('dd-MM-yyyy    hh:mm a')
                            .format(currentTransaction.currentDate),
                        textScaleFactor: 1.5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void getOutDetails(ColdStoreInTransaction currentTransaction) {
    database
        .getAllOutTransactionsForTransaction(inTransaction.transactionId)
        .listen((event) {
          event.sort((a,b){
            return a.currentDate.isBefore(b.currentDate)?1:-1;
          });
      setState(() {
        outTransactions = event;
      });
    });
  }

  void getCurrentTransactionDetails() {
    database
        .getParticularInTransaction(widget.currentTransaction.transactionId)
        .listen((event) {
      setState(() {
        inTransaction = event;
      });
    });
  }
}

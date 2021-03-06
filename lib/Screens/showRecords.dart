import 'dart:async';

import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:coldstore/Screens/RecordDetails.dart';
import 'package:coldstore/Screens/ShowPersonRecords.dart';
import 'package:coldstore/Service/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ShowRecords extends StatefulWidget {
  @override
  _ShowRecordsState createState() => _ShowRecordsState();
}

class _ShowRecordsState extends State<ShowRecords> {
  Map<String, CustomList> totalTransactionMap = Map();
  StreamSubscription currentSubscription;

  @override
  void initState() {
    super.initState();
    getDataFromDatabase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contacts Plugin Example')),
        body: SafeArea(
          child: Container(
            color: Colors.grey[600],
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.vertical,
              itemCount: totalTransactionMap.values.length, //coupons.length,
              itemBuilder: (BuildContext context, int index) {
                if (!totalTransactionMap[
                        totalTransactionMap.keys.toList()[index]]
                    .isMultiple)
                  return myOnlyWidget(
                      context,
                      totalTransactionMap[
                              totalTransactionMap.keys.toList()[index]]
                          .coldStoreInTransaction);
                else {
                  return myMultipleWidget(
                      context,
                      totalTransactionMap[
                              totalTransactionMap.keys.toList()[index]]
                          .totalTransactions);
                }
              },
            ),
          ),
        ));
  }

  void getDataFromDatabase() {
    DatabaseService databaseService = DatabaseService();
    currentSubscription =
        databaseService.getAllInTransactions().listen((event) {
      event.sort((a, b) {
        return a.currentDate.isBefore(b.currentDate) ? 1 : -1;
      });
     setState(() {
       for (ColdStoreInTransaction e in event) {
         if (totalTransactionMap[e.contactNumber] == null) {
           totalTransactionMap[e.contactNumber] = new CustomList(
               coldStoreInTransaction: e,
               isMultiple: false,
               totalTransactions: null);
         } else {
           if (!totalTransactionMap[e.contactNumber].isMultiple) {
             totalTransactionMap[e.contactNumber] = new CustomList(
                 coldStoreInTransaction: null,
                 isMultiple: true,
                 totalTransactions: [
                   e,
                   totalTransactionMap[e.contactNumber].coldStoreInTransaction
                 ]);
           } else {
             totalTransactionMap[e.contactNumber].totalTransactions.add(e);
           }
         }
       }
     });
    });
  }

  Widget myOnlyWidget(
      BuildContext context, ColdStoreInTransaction currentTransaction) {
    return GestureDetector(
      onTap: () {
        gotoDetails(currentTransaction);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromRGBO(120, 255, 255, .0),
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' ${currentTransaction.contactName}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ' ${currentTransaction.contactNumber}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentTransaction.noOfTora != '')
                          Row(
                            children: [
                              Text('Tora  ',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                  ' ${currentTransaction.remainingTora}  /  ${currentTransaction.noOfTora}',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        if (currentTransaction.noOfBori != '')
                          Row(
                            children: [
                              Text('Bori  ',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                  ' ${currentTransaction.remainingBori}  /  ${currentTransaction.noOfBori}',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: LinearPercentIndicator(
                              lineHeight: 15,
                              percent: getCurrentPercentage(currentTransaction),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.blueAccent,
                              backgroundColor: Colors.red,
                              center: Text(
                                  (getCurrentPercentage(currentTransaction) *
                                          100.ceil())
                                      .toStringAsFixed(1)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat('dd-MM-yyyy hh:mm a')
                      .format(currentTransaction.currentDate),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myMultipleWidget(
      BuildContext context, List<ColdStoreInTransaction> currentTransaction) {
    return GestureDetector(
      onTap: () {
        gotoPersonalRecords(currentTransaction);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromRGBO(120, 255, 255, .0),
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' ${currentTransaction[0].contactName}',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ' ${currentTransaction[0].contactNumber}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children:<Widget> [for (ColdStoreInTransaction store in currentTransaction)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${currentTransaction.indexOf(store)+1}',style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy hh:mm a')
                                    .format(store.currentDate),
                                style: TextStyle(color: Colors.white),
                                textScaleFactor: 1.3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: LinearPercentIndicator(
                                      lineHeight: 15,
                                      percent: getCurrentPercentage(store),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.blueAccent,
                                      backgroundColor: Colors.red,
                                      center: Text(
                                          (getCurrentPercentage(store) *
                                              100.ceil())
                                              .toStringAsFixed(1)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  gotoDetails(ColdStoreInTransaction currentTransaction) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecordDetails(currentTransaction)));
  }

  void gotoPersonalRecords(List<ColdStoreInTransaction> currentTransaction) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowPersonalRecords(phoneNumber: currentTransaction[0].contactNumber)));

  }
}

class CustomList {
  ColdStoreInTransaction coldStoreInTransaction;
  List<ColdStoreInTransaction> totalTransactions;
  bool isMultiple = false;

  CustomList({
    this.coldStoreInTransaction,
    this.totalTransactions,
    this.isMultiple,
  });
}

getCurrentPercentage(ColdStoreInTransaction currentTransaction) {
  if (currentTransaction.noOfBori != '' && currentTransaction.noOfTora != '')
    return 1 -
        ((int.parse(currentTransaction.remainingBori) * 2 +
                int.parse(currentTransaction.remainingTora)) /
            (int.parse(currentTransaction.noOfBori) * 2 +
                int.parse(currentTransaction.noOfTora)));
  else {
    if (currentTransaction.noOfTora == '') {
      return 1 -
          (int.parse(currentTransaction.remainingBori) * 2) /
              (int.parse(currentTransaction.noOfBori) * 2);
    } else {
      return 1 -
          (int.parse(currentTransaction.remainingTora)) /
              (int.parse(currentTransaction.noOfTora));
    }
  }
}

import 'dart:async';

import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:coldstore/Screens/RecordDetails.dart';
import 'package:coldstore/Service/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ShowPersonalRecords extends StatefulWidget {
  final String phoneNumber;

  const ShowPersonalRecords({Key key, this.phoneNumber}) : super(key: key);
  @override
  _ShowPersonalRecordsState createState() => _ShowPersonalRecordsState();
}

class _ShowPersonalRecordsState extends State<ShowPersonalRecords> {
  List<ColdStoreInTransaction> currentTransactions = [];
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
              itemCount: currentTransactions.length, //coupons.length,
              itemBuilder: (BuildContext context, int index) {
                return myOnlyWidget(
                      context,
                    currentTransactions[index]);
              },
            ),
          ),
        ));
  }

  void getDataFromDatabase() {
    DatabaseService databaseService = DatabaseService();
    currentSubscription =
        databaseService.getAlInTransactionsForPhoneNumber(widget.phoneNumber).listen((event) {
          event.sort((a, b) {
            return a.currentDate.isBefore(b.currentDate) ? 1 : -1;
          });
          setState(() {
            currentTransactions = event;
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

  gotoDetails(ColdStoreInTransaction currentTransaction) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RecordDetails(currentTransaction)));
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

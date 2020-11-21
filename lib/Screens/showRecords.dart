import 'dart:async';

import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:coldstore/Screens/RecordDetails.dart';
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
  List<ColdStoreTransaction> currentTransactions = [];

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
                return myCustomWidget(context, currentTransactions[index]);
              },
            ),
          ),
        ));
  }

  void getDataFromDatabase() {
    DatabaseService databaseService = DatabaseService();
    StreamSubscription currentSubscription;
    currentSubscription =
        databaseService.getAllFuelTransactions().listen((event) {
      setState(() {
        currentTransactions = event;
      });
      currentSubscription.cancel();
    });
  }


  Widget myCustomWidget(
      BuildContext context, ColdStoreTransaction currentTransaction) {
    return GestureDetector(
      onTap: (){
        gotoDetails(currentTransaction);
      },
      child: Card(
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
                              Text('Tora  ', style: TextStyle(color: Colors.white)),
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
                              Text('Bori  ', style: TextStyle(color: Colors.white)),
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

  gotoDetails(ColdStoreTransaction currentTransaction) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecordDetails(currentTransaction)));
  }
}


getCurrentPercentage(ColdStoreTransaction currentTransaction) {
  if (currentTransaction.noOfBori != '' && currentTransaction.noOfTora != '')
    return (int.parse(currentTransaction.noOfBori) * 2 +
            int.parse(currentTransaction.noOfTora) -
            int.parse(currentTransaction.remainingBori) * 2 -
            int.parse(currentTransaction.remainingTora)) /
        100;
  else {
    if (currentTransaction.noOfTora == '') {
      return (int.parse(currentTransaction.noOfBori) * 2 -
              int.parse(currentTransaction.remainingBori) * 2) /
          100;
    } else {
      return (int.parse(currentTransaction.noOfTora) -
              int.parse(currentTransaction.remainingTora)) /
          100;
    }
  }
}

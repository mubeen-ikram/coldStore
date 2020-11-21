import 'dart:async';

import 'package:coldstore/ModelClasses/StorageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordDetails extends StatefulWidget {
  final ColdStoreTransaction currentTransaction;

  RecordDetails(this.currentTransaction);

  @override
  _RecordDetailsState createState() => _RecordDetailsState();
}

class _RecordDetailsState extends State<RecordDetails> {
  @override
  void initState() {
    super.initState();
    getOutDetails(widget.currentTransaction);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contacts Plugin Example')),
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

  MyMainCard(ColdStoreTransaction currentTransaction) {
    return Card(
      clipBehavior: Clip.hardEdge,
        child: Column(
      children: [
        Row(
          children: [
            Text(currentTransaction.contactName),
            Text(currentTransaction.contactNumber),
          ],
        ),
        if(currentTransaction.noOfTora!='')
          Text('Tora'),
        if(currentTransaction.noOfTora!='')
          Row(
          children: [
            Text('Total: '),
            Text('${currentTransaction.noOfTora}'),
            Text('Stored'),
            Text('${currentTransaction.remainingTora}'),
          ],
        ),
        if(currentTransaction.noOfBori!='')
          Text('Bori'),
        if(currentTransaction.noOfBori!='')
          Row(
          children: [
            Text('Total: '),
            Text('${currentTransaction.noOfBori}'),
            Text('Stored'),
            Text('${currentTransaction.remainingBori}'),
          ],
        ),
        Row(
          children: [
            Text('Transaction Date'),
            Text(DateFormat('dd-MM-yyyy hh:mm a')
                .format(currentTransaction.currentDate),),
          ],
        ),

      ],
    ));
  }

  void getOutDetails(ColdStoreTransaction currentTransaction) {

  }
}

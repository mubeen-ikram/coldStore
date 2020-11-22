import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ColdStoreInTransaction{
  String transactionId;
  String contactNumber;
  String contactName;
  String marker;
  String typeOfPotato;
  String sizeOfPotato;
  String noOfBori;
  String noOfTora;
  String room;
  String rack;
  String direction;
  String position;
  String height;
  String remainingBori;
  String remainingTora;
  DateTime currentDate;


  ColdStoreInTransaction(
      {this.transactionId,
        this.contactNumber,
        this.contactName,
        this.marker,
        this.typeOfPotato,
        this.sizeOfPotato,
        this.noOfBori,
        this.noOfTora,
        this.room,
        this.rack,
        this.direction,
        this.position,
        this.height,
        this.remainingBori,
        this.remainingTora,
        this.currentDate,
      });

  Map<String,dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'contactNumber': contactNumber,
      'contactName': contactName,
      'marker': marker,
      'typeOfPotato': typeOfPotato,
      'sizeOfPotato': sizeOfPotato,
      'noOfBori': noOfBori,
      'noOfTora': noOfTora,
      'room': room,
      'rack': rack,
      'direction': direction,
      'position': position,
      'height': height,
      'remainingBori': remainingBori,
      'remainingTora': remainingTora,
      'currentDate': currentDate,
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.transactionId = doc.data['transactionId'] ?? '';
    this.contactNumber = doc.data['contactNumber'];
    this.contactName = doc.data['contactName'];
    this.marker = doc.data['marker'] ?? '';
    this.typeOfPotato = doc.data['typeOfPotato'] ?? '';
    this.sizeOfPotato = doc.data['sizeOfPotato'];
    this.noOfBori = doc.data['noOfBori'];
    this.noOfTora = doc.data['noOfTora'];
    this.room = doc.data['room'];
    this.rack = doc.data['rack'];
    this.direction = doc.data['direction'];
    this.position = doc.data['position'];
    this.height = doc.data['height'];
    this.remainingBori = doc.data['remainingBori'];
    this.remainingTora = doc.data['remainingTora'];
    this.currentDate = doc.data['currentDate'].toDate();
  }
}
class ColdStoreOutTransaction{
  String transactionId;
  String inTransactionId;
  String boriBefore;
  String toraBefore;
  String boriAfter;
  String toraAfter;
  DateTime currentDate;


  ColdStoreOutTransaction(
      {
        this.transactionId,
        this.inTransactionId,
        this.boriBefore,
        this.toraBefore,
        this.boriAfter,
        this.toraAfter,
        this.currentDate,
      });

  Map<String,dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'inTransactionId': inTransactionId,
      'boriBefore': boriBefore,
      'toraBefore': toraBefore,
      'boriAfter': boriAfter,
      'toraAfter': toraAfter,
      'currentDate': currentDate,
    };
  }

  void fromMap(DocumentSnapshot doc) {
    this.transactionId = doc.data['transactionId'] ?? '';
    this.inTransactionId = doc.data['inTransactionId'] ?? '';
    this.boriBefore = doc.data['boriBefore'];
    this.toraBefore = doc.data['toraBefore'];
    this.boriAfter = doc.data['boriAfter'] ?? '';
    this.toraAfter = doc.data['toraAfter'] ?? '';
    this.currentDate = doc.data['currentDate'].toDate();
  }
}


class ErrorDialog extends StatelessWidget {
  final String title,message;

  const ErrorDialog( this.title, this.message);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4.0,
      backgroundColor: Colors.transparent,
      child: _builderChild(context),
    );
  }
  _builderChild(BuildContext context) => Container(
    width: 900,
    height: 300,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
        Icons.error_outline_rounded,
        size: 180,
        color: Color.fromRGBO(255, 0, 0,1),
      ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(fontSize: 20),
        ),

        Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 2,
        )
      ],
    ),
  );

}



// class Contacts {
//   String contactId;
//   String cardName;
//   String cardPhone;
// }
// class Racks{
//   String rackId;
//   String level;
//   List<Position> position;
//   String roomNo;
//   String side;
//   String rackNo;
// }
// class Position{
//   String positionId;
//   String transactionId;
//   String position;
// }
// class InputRecord{
//   String contactId;
//   String recordId;
//   String roomId;
//   String rackId;
//   int toraQuantity;
//   int boriQuantity;
//   DateTime recordDate;
//   String type;
//   String size;
//   String marker='';
// }
// class OutputRecord{
//   String contactId;
//   String recordId;
//   String inputRecordId;
//   String roomId;
//   String rackId;
//   int toraQuantity;
//   int boriQuantity;
//   DateTime recordDate;
//   String type;
//   String size;
//   String marker='';
// }





import 'dart:core';

class Contacts {
  String contactId;
  String cardName;
  String cardPhone;
}

class Racks{
  String rackId;
  String level;
  List<Position> position;
  String roomNo;
  String side;
  String rackNo;
}

class Position{
  String positionId;
  String transactionId;
  String position;
}

class InputRecord{
  String contactId;
  String recordId;
  String roomId;
  String rackId;
  int toraQuantity;
  int boriQuantity;
  DateTime recordDate;
  String type;
  String size;
  String marker='';
}
class OutputRecord{
  String contactId;
  String recordId;
  String inputRecordId;
  String roomId;
  String rackId;
  int toraQuantity;
  int boriQuantity;
  DateTime recordDate;
  String type;
  String size;
  String marker='';
}





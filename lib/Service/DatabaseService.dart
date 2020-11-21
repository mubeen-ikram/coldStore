
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coldstore/ModelClasses/StorageModel.dart';

class DatabaseService {
  DatabaseService();



  //FuelTransactionQueries
  final CollectionReference inTransactionCollection =
  Firestore.instance.collection('ColdStoreInTransactions');

  Stream<List<ColdStoreTransaction>> getAllFuelTransactionsForPhoneNumber(String phoneNumber) {
    return inTransactionCollection
        .where("contactNumber", isEqualTo: phoneNumber)
        .snapshots()
        .map(_fuelTransactionDataListFromSnapshot);
  }

  Stream<ColdStoreTransaction> getParticularFuelTransaction(String id) {
    return inTransactionCollection
        .document(id)
        .snapshots()
        .map(_fuelTransactionDataFromSnapshot);
  }

  List<ColdStoreTransaction> _fuelTransactionDataListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _fuelTransactionDataFromSnapshot(doc);
    }).toList();
  }

  ColdStoreTransaction _fuelTransactionDataFromSnapshot(DocumentSnapshot doc) {
    ColdStoreTransaction current = ColdStoreTransaction();
    current.fromMap(doc);
    return current;
  }

  Future<void> setFuelTransactionData(ColdStoreTransaction transaction) async {
    return await inTransactionCollection
        .document(transaction.transactionId)
        .setData(transaction.toMap());
  }

  //Get randomID
  Future<String> getRandomId() async{
    return Firestore
        .instance
        .collection('')
        .document()
        .documentID;
  }

  Stream<List<ColdStoreTransaction>> getAllFuelTransactions() {
    return inTransactionCollection
        .snapshots()
        .map(_fuelTransactionDataListFromSnapshot);
  }



  //FuelTransactionQueries
  final CollectionReference outTransactionCollection =
  Firestore.instance.collection('ColdStoreOutTransactions');

  Stream<List<ColdStoreTransaction>> getAllOutTransactionsForPhoneNumber(String phoneNumber) {
    return outTransactionCollection
        .where("contactNumber", isEqualTo: phoneNumber)
        .snapshots()
        .map(_fuelTransactionDataListFromSnapshot);
  }

  Stream<List<ColdStoreTransaction>> getAllOutTransactionsForTransaction(String outTransaction) {
    return outTransactionCollection
        .where("inTransactionId", isEqualTo: outTransaction)
        .snapshots()
        .map(_fuelTransactionDataListFromSnapshot);
  }

  Stream<ColdStoreTransaction> getParticularOutTransaction(String id) {
    return outTransactionCollection
        .document(id)
        .snapshots()
        .map(_fuelTransactionDataFromSnapshot);
  }

  List<ColdStoreTransaction> _outTransactionDataListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _outTransactionDataFromSnapshot(doc);
    }).toList();
  }

  ColdStoreTransaction _outTransactionDataFromSnapshot(DocumentSnapshot doc) {
    ColdStoreTransaction current = ColdStoreTransaction();
    current.fromMap(doc);
    return current;
  }

  Future<void> setOutTransactionData(ColdStoreTransaction transaction) async {
    return await outTransactionCollection
        .document(transaction.transactionId)
        .setData(transaction.toMap());
  }

  Stream<List<ColdStoreTransaction>> getAllOutTransactions() {
    return outTransactionCollection
        .snapshots()
        .map(_fuelTransactionDataListFromSnapshot);
  }
}

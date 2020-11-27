
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coldstore/ModelClasses/StorageModel.dart';

class DatabaseService {
  DatabaseService();



  //FuelTransactionQueries
  final CollectionReference inTransactionCollection =
  Firestore.instance.collection('ColdStoreInTransactions');

  Stream<List<ColdStoreInTransaction>> getAlInTransactionsForPhoneNumber(String phoneNumber) {
    return inTransactionCollection
        .where("contactNumber", isEqualTo: phoneNumber)
        .snapshots()
        .map(_inTransactionDataListFromSnapshot);
  }

  Stream<ColdStoreInTransaction> getParticularInTransaction(String id) {
    return inTransactionCollection
        .document(id)
        .snapshots()
        .map(_inTransactionDataFromSnapshot);
  }

  List<ColdStoreInTransaction> _inTransactionDataListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _inTransactionDataFromSnapshot(doc);
    }).toList();
  }

  ColdStoreInTransaction _inTransactionDataFromSnapshot(DocumentSnapshot doc) {
    ColdStoreInTransaction current = ColdStoreInTransaction();
    current.fromMap(doc);
    return current;
  }

  Future<void> setInTransactionData(ColdStoreInTransaction transaction) async {
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

  Stream<List<ColdStoreInTransaction>> getAllInTransactions() {
    return inTransactionCollection
        .snapshots()
        .map(_inTransactionDataListFromSnapshot);
  }



  //FuelTransactionQueries
  final CollectionReference outTransactionCollection =
  Firestore.instance.collection('ColdStoreOutTransactions');

  Stream<List<ColdStoreOutTransaction>> getAllOutTransactionsForPhoneNumber(String phoneNumber) {
    return outTransactionCollection
        .where("contactNumber", isEqualTo: phoneNumber)
        .snapshots()
        .map(_outTransactionDataListFromSnapshot);
  }

  Stream<List<ColdStoreOutTransaction>> getAllOutTransactionsForTransaction(String outTransaction) {
    return outTransactionCollection
        .where("inTransactionId", isEqualTo: outTransaction)
        .snapshots()
        .map(_outTransactionDataListFromSnapshot);
  }

  Stream<ColdStoreInTransaction> getParticularOutTransaction(String id) {
    return outTransactionCollection
        .document(id)
        .snapshots()
        .map(_inTransactionDataFromSnapshot);
  }

  List<ColdStoreOutTransaction> _outTransactionDataListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return _outTransactionDataFromSnapshot(doc);
    }).toList();
  }

  ColdStoreOutTransaction _outTransactionDataFromSnapshot(DocumentSnapshot doc) {
    ColdStoreOutTransaction current = ColdStoreOutTransaction();
    current.fromMap(doc);
    return current;
  }

  Future<void> setOutTransactionData(ColdStoreOutTransaction transaction) async {
    return await outTransactionCollection
        .document(transaction.transactionId)
        .setData(transaction.toMap());
  }

  Stream<List<ColdStoreOutTransaction>> getAllOutTransactions() {
    return outTransactionCollection
        .snapshots()
        .map(_outTransactionDataListFromSnapshot);
  }
}

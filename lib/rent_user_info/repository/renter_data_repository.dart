import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:library_system/rent_user_info/ItemModel.dart';

class RenterDataRepository {
  Future<List<RenterModel>> getAllRenterData() async {
    QuerySnapshot qShot =
        await FirebaseFirestore.instance.collection('Renter Info').orderBy('time',descending: true).get();

    return qShot.docs
        .map((doc) => RenterModel(
            bookId: doc.data()['bookId'],
            time: doc.data()['time'],
            userName: doc.data()['userName']))
        .toList();
  }
}

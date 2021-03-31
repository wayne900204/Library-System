import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:library_system/book_info/model/book_info_model.dart';

class QrCodeRepository {
  /// 如果 userName 是空的|| 上面目前沒有這本書的話
  Future<String> getActivityType(String bookNumber, String userName) async {
    String status = await getStatus(bookNumber);
    if (userName != '' && status == "") {
      await updateStatus(bookNumber, userName);
      return 'Borrow Book Success~';
    } else if (userName != "" && userName == status) {
      await updateStatus(bookNumber, '');
      return 'Return Book Success~';
    } else if (userName != "") {
      return 'Someone have been borrow!';
    } else {
      return '';
    }
  }

  /// updateStatus
  Future<bool> updateStatus(String bookNumber, String userName) async {
    //get date time
    final now = DateTime.now();
    Map<String, Object> mapBody = HashMap();
    mapBody["status"] = userName;
    mapBody["date"] = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(now);
    return await FirebaseFirestore.instance
        .collection("Books Info")
        .doc(bookNumber)
        .update(mapBody)
        .then((data) {
      return true;
    }).catchError((e) {
      print('save Data' + e.toString());
      return false;
    });
  }

  /// getStatus
  Future<String> getStatus(String bookNumber) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('Books Info')
        .doc(bookNumber)
        .get();
    String status = ds.data()['status'].toString();

    return status;
  }
}

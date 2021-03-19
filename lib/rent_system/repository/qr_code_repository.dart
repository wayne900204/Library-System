import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class QrCodeRepository {
  /// save bookID time userName
  Future<bool> saveData(String bookId, String userName) async {
    //get date time
    final now = DateTime.now();
    var date = DateFormat("yyyy-MM-dd").format(now);
    // String mDate = date.format(dateTime);
    var time = DateFormat("H:m:s").format(now);
    //crate map data
    Map<String, Object> mapBody = HashMap();
    mapBody["bookId"] = bookId;
    mapBody["time"] = now.toString();
    mapBody['userName'] = userName ?? "";


    Map<String, Object> BookInfo = HashMap();

    BookInfo['status'] = userName ?? "";
    await FirebaseFirestore.instance
        .collection("Books Info")
        .doc('$bookId')
        .update(BookInfo);


    return await FirebaseFirestore.instance
        .collection("Renter Info")
        .doc('$bookId')
        .set(mapBody)
        .then((data) {
      return true;
    }).catchError((e) {
      print('save Data' + e.toString());
      return false;
    });
  }

  /// check  is this book publish
  Future<bool> isPublish(String bookId) async {
    bool boo;
    try {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection("Renter Info")
          .doc('$bookId')
          .get();
      final data = ds.data()['userName'].toString();
      boo = true;
    } catch (_) {
      boo = false;
    }
    return boo;
  }

  /// get userName
  Future<String> getUserNameData(String bookId, String userName) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection('Renter Info')
        .doc(bookId)
        .get();
    final data = ds.data()['userName'].toString();

    return data;
  }

  /// 如果 userName 是空的|| 上面目前沒有這本書的話
  Future<String> getActivityType(String bookId, String userName) async {
    if(bookId=="-1"){
      return 'Cancel Success';
    }
    else if (await isPublish(bookId)) {
      print(isPublish(bookId));
      print("isPublish");
      String dataBaseUserName = await getUserNameData(bookId, userName);
      print(getUserNameData(bookId, userName));
      if (userName != '' && dataBaseUserName == '') {
        print("ccc" + "BORROW");
        await saveData(bookId, userName);
        return 'Borrow Book Success~';
      } else if (userName != "" && dataBaseUserName == userName) {
        print("ccc" + "RETURN");
        await saveData(bookId, '');
        return 'Return Book Success~';
      } else if (userName != "") {
        print("ccc" + userName + "      " + dataBaseUserName);
        print("ccc" + "HAVEBEENBORROW");
        return 'Someone have been borrow!';
      } else {
        return '';
      }
    } else {
      if (userName != '') {
        print("ccc" + "BORROW");
        await saveData(bookId, userName);
        return 'Borrow Book Success~';
      } else {
        return '';
      }
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_system/book_info/model/book_info_model.dart';

class RenterDataRepository {
  /// get All Renter Data
  Future<List<BookInfoModel>> getAllRenterData() async {
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('Books Info')
        .orderBy('date', descending: true)
        .get();

    List<BookInfoModel> list=  qShot.docs.map((doc) {
      if(doc.data()['status']!=""&&doc.data()['status']!=null){
        return BookInfoModel(
            ISBN: doc.data()['isbn'].toString(),
            bookAuthor: doc.data()['book_author'],
            bookName: doc.data()['book_name'],
            bookNumber: doc.data()['book_number'],
            group: doc.data()['group'],
            imageUrl: doc.data()['image_url'],
            date: doc.data()['date'].toString(),
            status: doc.data()['status']);
      }
    }).toList();
     list.removeWhere((element) => element==null);
     return list;
  }
}

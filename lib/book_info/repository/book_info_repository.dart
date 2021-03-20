import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:library_system/book_info/model/book_info_model.dart';

class BookInfoRepository{
  Future<List<BookInfoModel>> getBookInfo() async{
    QuerySnapshot qShot =
    await FirebaseFirestore.instance.collection('Books Info').get();

    return qShot.docs
        .map((doc) => BookInfoModel(
      ISBN:  doc.data()['isbn'].toString(),
      bookAuthor:  doc.data()['book_author'],
      bookName:  doc.data()['book_name'],
      bookNumber:  doc.data()['book_number'],
      group:  doc.data()['group'],
        imageUrl: doc.data()['image_url'],
      status:  doc.data()['status'])).toList();

  }
}
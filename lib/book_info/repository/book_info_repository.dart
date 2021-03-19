import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:library_system/book_info/model/book_info_model.dart';

class BookInfoRepository{
  Future<List<BookInfoModel>> getBookInfo() async{
    QuerySnapshot qShot =
    await FirebaseFirestore.instance.collection('Books Info').get();

    return qShot.docs
        .map((doc) => BookInfoModel(
      ISBN:  doc.data()['ISBN'],
      bookAuthor:  doc.data()['book author'],
      bookName:  doc.data()['book name'],
      bookNumber:  doc.data()['book number'],
      group:  doc.data()['group'],
        imageUrl: doc.data()['image url'],
      status:  doc.data()['status'])).toList();

  }
}
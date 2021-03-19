import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class BookInfoModel{
  // ignore: non_constant_identifier_names
  String ISBN;
  String bookAuthor;
  String bookName;
  String bookNumber;
  String group;
  String status;
  String imageUrl;
  BookInfoModel({this.ISBN,this.bookAuthor,this.bookName,this.bookNumber,this.group,this.status,this.imageUrl});


  BookInfoModel.fromJson(DocumentSnapshot json)
      : ISBN = json.get("ISBN"),
        bookAuthor = json.get("bookAuthor"),
        bookName = json.get("bookName"),
        bookNumber = json.get("bookNumber"),
        group = json.get("group"),
        status = json.get("status");

}
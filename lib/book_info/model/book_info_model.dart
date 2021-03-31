import 'package:cloud_firestore/cloud_firestore.dart';

class BookInfoModel {
  // ignore: non_constant_identifier_names
  String ISBN;
  String bookAuthor;
  String bookName;
  String bookNumber;
  String group;
  String status;
  String imageUrl;
  String date;

  BookInfoModel(
      {this.ISBN,
      this.bookAuthor,
      this.bookName,
      this.bookNumber,
      this.group,
      this.status,
      this.imageUrl,
      this.date});

  BookInfoModel.fromJson(DocumentSnapshot json)
      : ISBN = json.get("ISBN"),
        bookAuthor = json.get("bookAuthor"),
        bookName = json.get("bookName"),
        bookNumber = json.get("bookNumber"),
        group = json.get("group"),
        date = json.get('date'),
        status = json.get("status");
}

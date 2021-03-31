import 'package:flutter/material.dart';
import 'package:library_system/rent_system/QR_bar_page.dart';
import 'package:library_system/rent_user_info/renter_listview_page.dart';

import 'book_info/book_info_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.8, 0.9],
          colors: [
            Colors.orange[100],
            Colors.orange[400],
            Colors.orange[500],
            Colors.orange[600],
            Colors.orange[700],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBookInfo(context, size),
              _buildRenterInfo(context, size),
            ],
          ),
        ),
      ),
    );
  }

  /// 查看書籍資訊
  Widget _buildBookInfo(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new BookInfo())),
      child: Container(
        width: size.width * 0.7,
        // height: size.height*0.,
        margin: EdgeInsets.only(top: size.height * 0.03),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          'Book Info',
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.cyan[700],
              fontWeight: FontWeight.bold),
        ),
        // child: ,
      ),
    );
  }

  /// 查看借閱狀況
  Widget _buildRenterInfo(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => new RenterListPage())),
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        width: size.width * 0.7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          '查看借閱狀況',
          style: TextStyle(
              color: Colors.cyan[700],
              fontWeight: FontWeight.bold,
              fontSize: 30),
          textAlign: TextAlign.center,
        ),
        // child: ,
      ),
    );
  }
}

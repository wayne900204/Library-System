import 'package:flutter/material.dart';
import 'package:library_system/rent_system/QR_bar.dart';
import 'package:library_system/rent_user_info/renter_listview.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildJoin(context, size),
            _buildCreate(context, size),
          ],
        ),
      ),
    );
  }

  /// 借／還書
  Widget _buildJoin(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => new QRCodeBar())),
      child: Container(
        width: size.width * 0.7,
        // height: size.height*0.,
        margin: EdgeInsets.only(top: size.height * 0.03),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
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
          '借／還書',
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
  Widget _buildCreate(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () =>Navigator.push(
          context, MaterialPageRoute(builder: (context) => new RenterList())),
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.03),
        width: size.width * 0.7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
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

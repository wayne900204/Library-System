import 'package:flutter/material.dart';
import 'package:library_system/book_info/model/book_info_model.dart';

import 'book_info_detail.dart';
class BookInfoItem extends StatelessWidget {


  final BookInfoModel bookInfoModel;
  BookInfoItem({this.bookInfoModel});
  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetail(bookInfoModel: bookInfoModel,)));
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        width: size.width*0.75,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
             Radius.circular(10.0),
            ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(bookInfoModel.imageUrl,height: 150,width: size.width*0.27,fit: BoxFit.fill,)),
            Container(
              width: size.width*0.48,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bookInfoModel.bookName,style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bookInfoModel.status==''?'借閱狀況：可借閱':'借閱狀況：已借出',style: TextStyle(color: Colors.grey
                      ),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

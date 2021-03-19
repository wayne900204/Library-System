
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/book_info/model/book_info_model.dart';
import 'package:library_system/book_info/widgets/book_info_listView_item.dart';
import 'package:library_system/rent_system/bloc/qr_code_bloc.dart';

import '../book_info_page.dart';
import 'book_info_dialog.dart';



class BookDetail extends StatelessWidget {
  final BookInfoModel bookInfoModel;

  BookDetail({this.bookInfoModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<QrCodeBloc, QrCodeState>(
        listener: (context, state) {
          if (state is QrCodeInitial) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Logging In...'),
                      CircularProgressIndicator(),
                    ],
                  )));
          }
          if (state is QrCodeIsSuccessful) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text(state.activityType), Icon(Icons.check)],
                ),
                backgroundColor: Colors.cyan,
              ));
          }
          if (state is QrCodeIsFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ));
          }
          return Container();
        },
        builder: (context, state) {
          return OrientationBuilder(builder: (context, orientation){
            if(orientation ==Orientation.portrait){//直立
              return buildPortrait(size,context);
            }else{
              return Container(
                color: Colors.red,
              );
            }
          });
        },
      ),
    );
  }

  Scaffold buildPortrait(Size size, BuildContext context){
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text(
          'Renter Info',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BookInfo()));
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,)
        )
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.35,
                width: size.width,
                child: Image.network(
                  bookInfoModel.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                height: size.height*0.5,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          child: AutoSizeText("Book Name："+
                              bookInfoModel.bookName,
                            style: TextStyle(fontSize: 50),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      AutoSizeText("Book Author："+
                        bookInfoModel.bookAuthor,
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      AutoSizeText('ISBN：'+
                          bookInfoModel.ISBN,
                        style: TextStyle(fontSize: 22),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      AutoSizeText(
                        bookInfoModel.bookAuthor,
                        style: TextStyle(fontSize: 22),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      AutoSizeText(
                        "Book Group："+
                            bookInfoModel.group,
                        style: TextStyle(fontSize: 22),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      AutoSizeText(
                        "Book Number："+
                           bookInfoModel.bookNumber,
                        style: TextStyle(fontSize: 22),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  _openDialog(context);
                },
                child: Container(
                  child: AutoSizeText(
                    "借閱",
                    style: TextStyle(fontSize: 23),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),);
  }

  Future _openDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BookInfoDialog(ISBN: bookInfoModel.ISBN);
      },
    );

  }
}


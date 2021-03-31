import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/book_info/model/book_info_model.dart';
import 'package:library_system/book_info/bloc/borrow_bloc.dart';

import '../book_info_page.dart';
import 'book_info_dialog.dart';

class BookDetail extends StatelessWidget {
  final BookInfoModel bookInfoModel;

  BookDetail({this.bookInfoModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<BorrowBloc, BorrowState>(
        listener: (context, state) {
          if (state is BorrowInitial) {
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
          if (state is BorrowIsSuccessful) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(state.activityType),
                    Icon(Icons.check)
                  ],
                ),
                backgroundColor: Colors.cyan,
              ));
          }
          if (state is BorrowIsFailure) {
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
          return OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              //直立
              return buildPortrait(size, context);
            } else {
              return buildLandscape(size, context);
            }
          });
        },
      ),
    );
  }
  ///LandScape
  Container buildLandscape(Size size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.8, 0.9],
          colors: [
            Colors.blueAccent[100],
            Colors.blueAccent[200],
            Colors.orange[500],
            Colors.orange[600],
            Colors.orange[700],
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.cyan[400],
            title: Text(
              'Renter Info',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BookInfo()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.9 - 85,
                      width: size.width * 0.5,
                      child: Image.network(
                        bookInfoModel.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    getAllDetail(
                        context, size.width * 0.5, size.height * 0.9 - 85)
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _openDialog(context);
                  },
                  child: Container(
                    height: 40,
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
        ),
      ),
    );
  }
  /// Portrait
  Container buildPortrait(Size size, BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text(
              'Renter Info',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BookInfo()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    color: Colors.redAccent,
                  ),
                  height: size.height * 0.35,
                  child: Image.network(
                    bookInfoModel.imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  child: getAllDetail(context, size.width, size.height * 0.5),
                ),
                GestureDetector(
                  onTap: () {
                    _openDialog(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    color: Colors.redAccent[400],
                    child: AutoSizeText(
                      "借閱",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Table
  Widget getAllDetail(BuildContext context, double width, double height) {
    return Container(
      width: width,
      height: height,
      child: DataTable(
        headingRowHeight: 0,
        columns: const <DataColumn>[
          DataColumn(
            numeric: false,
            label: Text(''),
          ),
          DataColumn(
            numeric: false,
            label: Text(''),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Book Name：')),
              DataCell(Text(bookInfoModel.bookName))
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('bookAuthor：')),
              DataCell(
                Text(bookInfoModel.bookAuthor),
              )
              // DataCell(Text('Associate Professor')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('bookNumber：')),
              DataCell(
                Text(bookInfoModel.bookNumber),
              )
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('group：')),
              DataCell(Text(bookInfoModel.group))
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('ISBN：')),
              DataCell(Text(bookInfoModel.ISBN))
            ],
          ),
        ],
      ),
    );
  }
  /// openDialog
  Future _openDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BookInfoDialog(bookInfoModel: bookInfoModel);
      },
    );
  }
}

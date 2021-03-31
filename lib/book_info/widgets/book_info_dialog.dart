import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/book_info/model/book_info_model.dart';
import 'package:library_system/book_info/bloc/borrow_bloc.dart';

class BookInfoDialog extends StatefulWidget {
  // ignore: non_constant_identifier_names

  final BookInfoModel bookInfoModel;

  // ignore: non_constant_identifier_names
  BookInfoDialog({this.bookInfoModel});

  @override
  _BookInfoDialogState createState() => _BookInfoDialogState();
}

class _BookInfoDialogState extends State<BookInfoDialog> {
  final TextEditingController _userNameController = TextEditingController();

  BorrowBloc _qrCodeBloc;

  @override
  void initState() {
    super.initState();
    _qrCodeBloc = BlocProvider.of<BorrowBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please Enter your UserName'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Last name", _userNameController),
            GestureDetector(
              onTap: () {
                _qrCodeBloc.add(BorrowOnClick(
                    bookNumber: widget.bookInfoModel.bookNumber,
                    userName: _userNameController.text,
                    status: widget.bookInfoModel.status));
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: getAppBorderButton('Add')),
            ),
          ],
        ),
      ),
    );
  }
  /// TextField
  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );
  }
  /// AppBar
  Widget getAppBorderButton(String buttonLabel) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

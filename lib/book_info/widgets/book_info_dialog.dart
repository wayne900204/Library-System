import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/rent_system/bloc/qr_code_bloc.dart';
class BookInfoDialog extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String ISBN;
  // ignore: non_constant_identifier_names
  BookInfoDialog({this.ISBN});

  @override
  _BookInfoDialogState createState() => _BookInfoDialogState();
}

class _BookInfoDialogState extends State<BookInfoDialog> {
  final TextEditingController _userNameController = TextEditingController();

  QrCodeBloc _qrCodeBloc;
  @override
  void initState() {
    super.initState();
    _qrCodeBloc = BlocProvider.of<QrCodeBloc>(context);
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
                    _qrCodeBloc.add(QrCodeOnClick(bookId: widget.ISBN,userName: _userNameController.text));
                    Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: getAppBorderButton('Add')
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(String inputBoxName,
      TextEditingController inputBoxController) {
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

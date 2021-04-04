import 'package:flutter/material.dart';
import 'package:library_system/book_info/bloc/book_info_bloc.dart';
import 'package:library_system/book_info/model/book_info_model.dart';

class DropDownButton extends StatefulWidget {
  final List<BookInfoModel> bookInfoItems;
  final BookInfoBloc bookInfoBloc;

  DropDownButton({this.bookInfoItems, this.bookInfoBloc});

  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String _chosenValue;
  var users = <String>[
    '全部',
    'app',
    'hack',
    'server',
    '電腦硬體',
    'web',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.amber,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButtonFormField<String>(
        value: _chosenValue,
        dropdownColor: Colors.amber,
        //elevation: 5,
        style: TextStyle(color: Colors.black),
        items: users.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(
          "全部",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String value) {
          if (value == '全部') {
            widget.bookInfoBloc
                .add(BookInfoSearchUser('', widget.bookInfoItems));
          } else {
            widget.bookInfoBloc
                .add(BookInfoSearchUser(value, widget.bookInfoItems));
          }

          setState(() {
            _chosenValue = value;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/book_info/bloc/book_info_bloc.dart';
import 'package:library_system/book_info/model/book_info_model.dart';
import 'package:library_system/book_info/widgets/book_info_listView_item.dart';
import 'package:library_system/book_info/bloc/borrow_bloc.dart';
import 'package:library_system/book_info/widgets/book_info_dialog.dart';
import 'package:library_system/book_info/widgets/dropDownButton.dart';
import '../main_page.dart';

class BookInfo extends StatefulWidget {
  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  TextEditingController _searchController = TextEditingController();
  BookInfoBloc _bookInfoBloc;

  @override
  void initState() {
    super.initState();
    _bookInfoBloc = BlocProvider.of<BookInfoBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bookInfoBloc.add(BookInfoLoadItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.cyan[300],
            title: Text(
              'Renter Info',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
                // color: Colors.white,
                ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          // actions: [
          //   IconButton(icon: Icon(Icons.qr_code_scanner,color: Colors.white,), onPressed: () async{
          //     _openDialog(context);
          //   })
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            // ignore: close_sinks
            final itemsBloc = _bookInfoBloc..add(BookInfoLoadItemEvent());

            return itemsBloc.stream.firstWhere((e) => e is! BookInfoLoadItemEvent);
          },
          // child: _buildItemsList(),
          child: BlocConsumer<BorrowBloc, BorrowState>(
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
                      children: <Widget>[Text(state.activityType), Icon(Icons.check)],
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
              return _buildItemsList();
            },
          ),
        ),
      ),
    );
  }
  /// BuildListView and SearchBar
  Widget _buildItemsList() {
    final theme = Theme.of(context);

    return BlocBuilder<BookInfoBloc, BookInfoState>(
      buildWhen: (previous, current) => current is BookInfoStateLoaded,
      builder: (context, state) {
        if (state is BookInfoStateLoaded) {
          final items = state.items;
          return Column(
            children: [
              DropDownButton(bookInfoItems: items,bookInfoBloc: _bookInfoBloc),
              _searchField(items),
              Expanded(
                child: ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final model = items[index];
                    return BookInfoItem(bookInfoModel: model);
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                  ),
                  itemCount: items.length,
                ),
              ),
            ],
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  /// searchField
  Widget _searchField(List<BookInfoModel> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,right: 16,left: 16),
      child: TextFormField(
        style: TextStyle(fontSize: 14.0, color: Colors.black),
        controller: _searchController,
        onChanged: (changed) {
          _bookInfoBloc.add(BookInfoSearchUser(changed, items));
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon: _searchController.text.length > 0
              ? IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.grey[500],
                    size: 16.0,
                  ),
                  onPressed: () {})
              : Icon(
                  Icons.search_outlined,
                  color: Colors.grey[500],
                  size: 16.0,
                ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[100].withOpacity(0.3)),
              borderRadius: BorderRadius.circular(30.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[100].withOpacity(0.3)),
              borderRadius: BorderRadius.circular(30.0)),
          contentPadding: EdgeInsets.only(left: 15.0, right: 10.0),
          labelText: "Search...",
          hintStyle: TextStyle(
              fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.w500),
          labelStyle: TextStyle(
              fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        autocorrect: false,
        autovalidateMode: AutovalidateMode.always,
      ),
    );
  }
}

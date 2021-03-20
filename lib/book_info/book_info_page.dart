import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/book_info/bloc/book_info_bloc.dart';
import 'package:library_system/book_info/widgets/book_info_listView_item.dart';

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
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: Text(
          'Renter Info',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          // color: Colors.white,
        ),
          leading: IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage()));
              },
              icon: Icon(Icons.arrow_back,color: Colors.white,)
          )
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // ignore: close_sinks
          final itemsBloc = _bookInfoBloc..add(BookInfoLoadItemEvent());

          return itemsBloc.firstWhere((e) => e is! BookInfoLoadItemEvent);
        },
        child: _buildItemsList(),
      ),
    );
  }

  Widget _buildItemsList() {
    final theme = Theme.of(context);

    return BlocBuilder<BookInfoBloc, BookInfoState>(
      buildWhen: (previous, current) => current is BookInfoStateLoaded,
      builder: (context, state) {
        print(state);
        print("state");
        if (state is BookInfoStateLoaded) {
          final items = state.items;
          print(items.length);
          return ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final model = items[index];
              // https://i.imgur.com/ubWh7YM.jpg
              return BookInfoItem(bookInfoModel: model);
            },
            separatorBuilder: (context, index) => Divider(height: 1,),
            itemCount: items.length,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  // searchField
  Widget _searchField(){
    return           TextFormField(
      style: TextStyle(fontSize: 14.0, color: Colors.black),
      controller: _searchController,
      onChanged: (changed) {
        // _bookInfoBloc.isSearchUser.add(changed);
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: _searchController.text.length > 0 ? IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.grey[500], size: 16.0,),
            onPressed: () {}): Icon(Icons.search_outlined, color: Colors.grey[500], size: 16.0,),
        enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.grey[100].withOpacity(0.3)),
            borderRadius: BorderRadius.circular(30.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[100].withOpacity(0.3)),
            borderRadius: BorderRadius.circular(30.0)),
        contentPadding: EdgeInsets.only(
            left: 15.0, right: 10.0),
        labelText: "Search...",
        hintStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500),
        labelStyle: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.w500),
      ),
      autocorrect: false,
      autovalidateMode: AutovalidateMode.always,
    );
  }
  // appbar Actions
  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
          icon: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          // onPressed: (){_openAddUserDialog(false);}
      ),
    ];
  }
}

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
}

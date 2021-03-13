import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/rent_user_info/bloc/renter_data_bloc.dart';

class RenterList extends StatefulWidget {
  @override
  _RenterListState createState() => _RenterListState();
}

class _RenterListState extends State<RenterList> {
  RenterDataBloc _rentDataBloc;

  @override
  void initState() {
    super.initState();
    _rentDataBloc = BlocProvider.of<RenterDataBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rentDataBloc..add(RentDataRefreshEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Renter Info',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // ignore: close_sinks
          final itemsBloc = _rentDataBloc..add(RentDataRefreshEvent());

          return itemsBloc.firstWhere((e) => e is! RentDataRefreshEvent);
        },
        child: _buildItemsList(),
      ),
    );
  }

  Widget _buildItemsList() {
    final theme = Theme.of(context);

    return BlocBuilder<RenterDataBloc, RenterDataState>(
      buildWhen: (previous, current) => current is RenterStateLoaded,
      builder: (context, state) {
        print(state);
        print("state");
        if (state is RenterStateLoaded) {
          final items = state.items;
          print(items.length);
          return ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(
                  "Book Id: \n" + item.bookId,
                  style: theme.textTheme.headline6.copyWith(
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text("Time: " + item.time),
                trailing: Text(
                  "userName:\n" + item.userName,
                  style: theme.textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
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

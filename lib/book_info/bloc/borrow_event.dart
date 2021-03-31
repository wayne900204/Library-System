part of '../../book_info/bloc/borrow_bloc.dart';

@immutable
abstract class BorrowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BorrowOnClick extends BorrowEvent {
  final String bookNumber;
  final String userName;
  final String status;

  BorrowOnClick({this.bookNumber, this.userName, this.status});
}

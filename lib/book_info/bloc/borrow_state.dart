part of '../../book_info/bloc/borrow_bloc.dart';

@immutable
abstract class BorrowState {}

class BorrowInitial extends BorrowState {}

class BorrowIsSuccessful extends BorrowState {
  final String activityType;

  BorrowIsSuccessful({this.activityType});
}

class BorrowIsFailure extends BorrowState {}

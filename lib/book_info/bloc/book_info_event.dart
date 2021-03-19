part of 'book_info_bloc.dart';

@immutable
abstract class BookInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookInfoLoadItemEvent extends BookInfoEvent {}

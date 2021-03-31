part of 'book_info_bloc.dart';

@immutable
abstract class BookInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookInfoLoadItemEvent extends BookInfoEvent {}

class BookInfoSearchUser extends BookInfoEvent {
  final String text;
  final List<BookInfoModel> items;

  BookInfoSearchUser(this.text, this.items);
}

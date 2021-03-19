part of 'book_info_bloc.dart';

@immutable
abstract class BookInfoState extends Equatable{

  @override
  List<Object> get props =>[];
}

class BookInfoInitial extends BookInfoState {}


class BookInfoStateLoading extends BookInfoState {}

class BookInfoStateLoaded extends BookInfoState {
  final List<BookInfoModel> items;
  BookInfoStateLoaded({this.items });
}

class BookInfoRefreshing extends BookInfoState {}
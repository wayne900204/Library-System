import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_system/book_info/model/book_info_model.dart';
import 'package:library_system/book_info/repository/book_info_repository.dart';
import 'package:meta/meta.dart';

part 'book_info_event.dart';
part 'book_info_state.dart';

class BookInfoBloc extends Bloc<BookInfoEvent, BookInfoState> {
  BookInfoRepository bookInfoRepository = new BookInfoRepository();

  BookInfoBloc() : super(BookInfoInitial());

  @override
  Stream<BookInfoState> mapEventToState(
    BookInfoEvent event,
  ) async* {
    if (event is BookInfoLoadItemEvent) {
      yield BookInfoStateLoading();

      List<BookInfoModel> generatedItems = await bookInfoRepository.getBookInfo();
      print('abcccc');
      print(generatedItems.length);
      await Future<void>.delayed(Duration(seconds: 1));

      yield BookInfoStateLoaded(items: generatedItems);
    }
  }
}

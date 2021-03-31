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

      List<BookInfoModel> generatedItems =
          await bookInfoRepository.getBookInfo();
      await Future<void>.delayed(Duration(seconds: 1));

      yield BookInfoStateLoaded(items: generatedItems);
    }
    if (event is BookInfoSearchUser) {
      yield BookInfoStateLoading();

      List<BookInfoModel> generatedItems =
          await bookInfoRepository.getBookInfo();

      var dummyListData = List<BookInfoModel>();
      String text = event.text;
      generatedItems.forEach((stud) {
        var st2 = BookInfoModel(
            imageUrl: stud.imageUrl,
            status: stud.status,
            bookAuthor: stud.bookAuthor,
            bookName: stud.bookName,
            bookNumber: stud.bookNumber,
            ISBN: stud.ISBN,
            group: stud.group);
        if ((st2.imageUrl.toLowerCase()).contains(text.toLowerCase()) ||
            st2.status.toLowerCase().contains(text.toLowerCase()) ||
            st2.bookAuthor.toLowerCase().contains(text.toLowerCase()) ||
            st2.bookName.toLowerCase().contains(text.toLowerCase()) ||
            st2.bookNumber.toLowerCase().contains(text.toLowerCase()) ||
            st2.ISBN.toLowerCase().contains(text.toLowerCase()) ||
            st2.group.toLowerCase().contains(text.toLowerCase())) {
          dummyListData.add(stud);
        }
      });

      yield BookInfoStateLoaded(items: dummyListData);
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:library_system/book_info/repository/borrow_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'borrow_event.dart';

part 'borrow_state.dart';

class BorrowBloc extends Bloc<BorrowEvent, BorrowState> {
  QrCodeRepository qrCodeRepository;

  BorrowBloc(QrCodeRepository qrCodeRepository)
      : assert(qrCodeRepository != null),
        qrCodeRepository = qrCodeRepository,
        super(BorrowInitial());

  @override
  Stream<BorrowState> mapEventToState(BorrowEvent event) async* {
    // TODO: implement mapEventToState
    if (event is BorrowOnClick) {
      yield BorrowInitial();
      String activityType = await qrCodeRepository.getActivityType(
          event.bookNumber, event.userName ?? '');
      if (activityType == 'Borrow Book Success~' ||
          activityType == 'Return Book Success~' ||
          activityType == 'Someone have been borrow!' ||
          activityType == 'Cancel Success') {
        yield BorrowIsSuccessful(activityType: activityType);
      } else {
        yield BorrowIsFailure();
      }
    }
  }
}

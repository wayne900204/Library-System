import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:library_system/rent_system/repository/qr_code_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeRepository qrCodeRepository;

  QrCodeBloc(QrCodeRepository qrCodeRepository)
      : assert(qrCodeRepository != null),
        qrCodeRepository = qrCodeRepository,
        super(QrCodeInitial());

  @override
  Stream<QrCodeState> mapEventToState(QrCodeEvent event) async* {
    print("QrCodeInitial");
    // TODO: implement mapEventToState
    if (event is QrCodeOnClick) {
      print("QrCodeInitial");
      yield QrCodeInitial();
      String activityType = await qrCodeRepository.getActivityType(
          event.bookId, event.userName ?? '');
      print('activityType: ' + activityType.toString());
      if (activityType == 'Borrow Book Success~' ||
          activityType == 'Return Book Success~' ||
          activityType == 'Someone have been borrow!'||activityType =='Cancel Success') {
        yield QrCodeIsSuccessful(activityType: activityType);
      } else {
        print("Fail Error");
        yield QrCodeIsFailure();
      }
    }
  }
}

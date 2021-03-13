part of 'qr_code_bloc.dart';

@immutable
abstract class QrCodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QrCodeOnClick extends QrCodeEvent {
  final String bookId;
  final String userName;

  QrCodeOnClick({this.bookId, this.userName});
}

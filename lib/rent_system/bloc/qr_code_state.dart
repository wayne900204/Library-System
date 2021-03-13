part of 'qr_code_bloc.dart';

@immutable
abstract class QrCodeState {}

class QrCodeInitial extends QrCodeState {}

class QrCodeIsSuccessful extends QrCodeState {
  final String activityType;

  QrCodeIsSuccessful({this.activityType});
}

class QrCodeIsFailure extends QrCodeState {}

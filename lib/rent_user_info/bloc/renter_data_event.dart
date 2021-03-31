part of 'renter_data_bloc.dart';

@immutable
abstract class RenterDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RentDataLoadItemsEvent extends RenterDataEvent {}

class RentDataRefreshEvent extends RenterDataEvent {}

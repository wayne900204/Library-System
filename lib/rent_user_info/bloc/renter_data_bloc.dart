import 'dart:async';
import 'package:library_system/book_info/model/book_info_model.dart';
import 'package:library_system/rent_user_info/repository/renter_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'renter_data_event.dart';

part 'renter_data_state.dart';

class RenterDataBloc extends Bloc<RenterDataEvent, RenterDataState> {
  RenterDataRepository rentDataRepository = new RenterDataRepository();

  RenterDataBloc() : super(RentDataInitial());

  @override
  Stream<RenterDataState> mapEventToState(
    RenterDataEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is RentDataLoadItemsEvent) {
      yield RenterStateLoading();

      List<BookInfoModel> generatedItems =
          await rentDataRepository.getAllRenterData();
      yield RenterStateLoaded(items: generatedItems);
    }
    if (event is RentDataRefreshEvent) {
      yield RenterStateRefreshing();

      List<BookInfoModel> generatedItems =
          await rentDataRepository.getAllRenterData();

      await Future<void>.delayed(Duration(seconds: 1));

      yield RenterStateLoaded(items: generatedItems);
    }
  }
}

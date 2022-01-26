import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:equatable/equatable.dart';

part 'order_header_state.dart';
part 'order_header_event.dart';

class OrderHeaderBloc extends Bloc<OrderHeaderEvent, OrderHeaderState> {
  OrderHeaderBloc({required Report report})
      : super(OrderHeaderState(
          report: report,
          viewState: StateEnum.success,
        )) {
    on<ReloadReport>(handleOnReloadReport);
  }

  FutureOr<void> handleOnReloadReport(
      ReloadReport event, Emitter<OrderHeaderState> emit) {}
}

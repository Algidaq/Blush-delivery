import 'dart:async';

import 'package:blush_delivery/extensions/exception_ext.dart';
import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/interfaces/i_report_orders_service.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orders_state.dart';
part 'orders_event.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState>
    with ExceptionMessageExt {
  final IReportOrdersService orderService;
  final Report report;
  OrdersBloc({required this.orderService, required this.report})
      : super(const OrdersState()) {
    on<FetchOrders>(handleFetchOrders);
    on<ReorderOrder>(handleReorderOrder);
  }

  FutureOr<void> handleFetchOrders(
      FetchOrders event, Emitter<OrdersState> emit) async {
    try {
      emit(state.copyWith(viewState: StateEnum.busy));
      var orders = await orderService.getReportOrders(reportDate: report.date);
      emit(state.copyWith(viewState: StateEnum.success, orders: orders));
    } catch (e) {
      String message = getErrorMessage(e);
      emit(state.copyWith(viewState: StateEnum.error, message: message));
    }
  }

  FutureOr<void> handleReorderOrder(
      ReorderOrder event, Emitter<OrdersState> emit) {
    AppLogger.i('${event.oldIndex} ${event.newIndex}');
    var data = state.orders[event.oldIndex];
    var orders = [...state.orders];
    orders.removeAt(event.oldIndex);
    var newIndex = event.newIndex == state.orders.length
        ? event.newIndex - 1
        : event.newIndex;
    orders.insert(newIndex, data);
    emit(state.copyWith(orders: orders));
  }
}

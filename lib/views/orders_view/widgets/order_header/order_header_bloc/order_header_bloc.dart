import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/extensions/exception_ext.dart';
import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/reports_view/report_bloc/report_bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_header_state.dart';
part 'order_header_event.dart';

class OrderHeaderBloc extends Bloc<OrderHeaderEvent, OrderHeaderState>
    with ExceptionMessageExt {
  final IDriverReportService reportService;
  // final ReportBloc reportBloc;
  OrderHeaderBloc({
    required Report report,
    required this.reportService,
  }) : super(OrderHeaderState(
          report: report,
          oldReport: report,
          viewState: StateEnum.success,
        )) {
    on<ReloadReport>(handleOnReloadReport);
  }

  FutureOr<void> handleOnReloadReport(
      ReloadReport event, Emitter<OrderHeaderState> emit) async {
    try {
      emit(state.copyWith(viewState: StateEnum.busy));
      var newReport =
          await reportService.getReportByDate(date: state.report.date);

      emit(state.copyWith(
        viewState: StateEnum.success,
        report: newReport,
        oldReport: state.report,
      ));
    } catch (e) {
      var message = getErrorMessage(e);
      AppLogger.e(message, e);
      emit(state.copyWith(viewState: StateEnum.success));
    }
  }
}

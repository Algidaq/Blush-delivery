import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/extensions/exception_ext.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';
import 'package:blush_delivery/utils/app_logger.dart';

import 'package:blush_delivery/utils/state_enum.dart';
import 'package:equatable/equatable.dart';

part 'report_state.dart';
part 'report_event.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState>
    with ExceptionMessageExt {
  final IDriverReportService reportService;
  ReportBloc({required this.reportService}) : super(const ReportState()) {
    on<ReloadReports>(handleReloadReports);
    on<LoadReports>(handleLoadReports);
  }

  FutureOr<void> handleReloadReports(
      ReloadReports event, Emitter<ReportState> emit) async {
    try {
      var queryParams = getQueryParams(1);
      var res = await reportService.getDriverReports(queryParams: queryParams);
      emit(state.copyWith(
        viewState: StateEnum.success,
        reportResModel: res,
        hasReachedLimit: res.totalPages == queryParams.page,
      ));
    } catch (e) {
      addError(e);
    }
  }

  FutureOr<void> handleLoadReports(
      LoadReports event, Emitter<ReportState> emit) async {
    try {
      if (state.hasReachedLimit) {
        return;
      }
      var queryParams = getQueryParams(state.currentPage + 1);
      var res = await reportService.getDriverReports(queryParams: queryParams);
      emit(state.copyWith(
        viewState: StateEnum.success,
        currentPage: queryParams.page,
        hasReachedLimit: res.reports.isEmpty,
        reportResModel: res,
      ));
    } catch (e) {
      addError(e);
    }
  }

  DriverReportReqModel getQueryParams(int page, [int limit = 10]) {
    return DriverReportReqModel(page: page, limit: limit);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    var message = getErrorMessage(error);
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(viewState: StateEnum.error, message: message));
    super.onError(error, stackTrace);
  }

  @override
  void onChange(Change<ReportState> change) {
    AppLogger.i('onChange: ${change.toString()}');
    super.onChange(change);
  }
}

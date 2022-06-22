import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:blush_delivery/extensions/exception_ext.dart';
import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:equatable/equatable.dart';

part 'report_state.dart';
part 'report_event.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ReportBloc extends Bloc<ReportEvent, ReportState>
    with ExceptionMessageExt {
  final IDriverReportService reportService;
  ReportBloc({required this.reportService}) : super(const ReportState()) {
    on<ReloadReports>(handleReloadReports);
    on<LoadReports>(handleLoadReports,
        transformer: throttleDroppable(throttleDuration));
    on<UpdateReport>(handleUpdateReport);
    on<RestoreState>(handleStateRestoreation);
  }

  FutureOr<void> handleReloadReports(
      ReloadReports event, Emitter<ReportState> emit) async {
    try {
      emit(state.copyWith(viewState: StateEnum.busy));
      var queryParams = getQueryParams(1);
      var res = await reportService.getDriverReports(queryParams: queryParams);
      emit(state.copyWith(
        viewState: StateEnum.success,
        reportResModel: res,
        hasReachedLimit: res.totalPages == queryParams.page,
        currentPage: queryParams.page,
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
      AppLogger.d('onreloadd $res');
      if (res.reports.isEmpty) {
        AppLogger.d('isEmpty');
        emit(state.copyWith(hasReachedLimit: res.reports.isEmpty));
      } else {
        res.reports.insertAll(0, state.reportResModel?.reports ?? []);
        emit(state.copyWith(
          viewState: StateEnum.success,
          currentPage: queryParams.page,
          // hasReachedLimit: hasReachedLimit,
          reportResModel: res,
        ));
      }
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

  FutureOr<void> handleUpdateReport(
      UpdateReport event, Emitter<ReportState> emit) {
    var reports = [...state.reportResModel!.reports];
    var index = reports.indexOf(event.oldReport);
    reports[index] = event.newReport;
    emit(state.copyWith(
        reportResModel: state.reportResModel!.copyWith(reports: reports)));
  }

  void handleStateRestoreation(RestoreState event, Emitter<ReportState> emit) {
    emit(state.copyWith(
        viewState: event.reportState.viewState,
        reportResModel: event.reportState.reportResModel,
        hasReachedLimit: event.reportState.hasReachedLimit,
        currentPage: event.reportState.currentPage,
        message: event.reportState.message));
  }
}

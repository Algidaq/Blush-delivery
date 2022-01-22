part of 'report_bloc.dart';

class ReportState extends Equatable {
  final StateEnum viewState;
  final DriverReportResModel? reportResModel;
  final String message;
  final bool hasReachedLimit;
  final int currentPage;
  const ReportState(
      {this.viewState = StateEnum.busy,
      this.reportResModel,
      this.message = '',
      this.hasReachedLimit = false,
      this.currentPage = 1});

  ReportState copyWith(
          {StateEnum? viewState,
          DriverReportResModel? reportResModel,
          String? message,
          int? currentPage,
          bool? hasReachedLimit}) =>
      ReportState(
          viewState: viewState ?? this.viewState,
          reportResModel: reportResModel ?? this.reportResModel,
          message: message ?? this.message,
          currentPage: currentPage ?? this.currentPage,
          hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit);
  @override
  List<Object?> get props => [
        viewState,
        reportResModel,
        message,
        hasReachedLimit,
        currentPage,
      ];
}

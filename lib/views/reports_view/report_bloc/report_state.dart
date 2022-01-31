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
  factory ReportState.fromJson(Map<String, dynamic> json) {
    var viewState = StateEnum.values[json['viewState'] ?? 0];
    var message = json['message'] ?? '';
    var hasReachedLimit = json['hasReachedLimit'] ?? false;
    var currentPage = json['currentPage'] ?? 0;
    return ReportState(
        viewState: viewState,
        message: message,
        hasReachedLimit: hasReachedLimit,
        currentPage: currentPage,
        reportResModel: json['reportResModel'] == null
            ? DriverReportResModel()
            : DriverReportResModel.fromRestoreJson(json['reportResModel']));
  }
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

  Map<String, dynamic> toJson() {
    return {
      'viewState': viewState.index,
      'reportResModel': reportResModel?.toJson(),
      'message': message,
      'hasReachedLimit': hasReachedLimit,
      'currentPage': currentPage
    };
  }
}

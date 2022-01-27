part of 'order_header_bloc.dart';

class OrderHeaderState extends Equatable {
  final Report report;
  final Report oldReport;
  final StateEnum viewState;
  const OrderHeaderState(
      {required this.report, required this.viewState, required this.oldReport});

  OrderHeaderState copyWith({
    Report? report,
    StateEnum? viewState,
    Report? oldReport,
  }) =>
      OrderHeaderState(
        report: report ?? this.report,
        oldReport: oldReport ?? this.report,
        viewState: viewState ?? this.viewState,
      );
  @override
  List<Object?> get props => [viewState, report, oldReport];
}

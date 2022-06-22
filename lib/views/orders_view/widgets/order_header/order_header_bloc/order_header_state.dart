part of 'order_header_bloc.dart';

class OrderHeaderState extends Equatable {
  final Report report;
  final Report oldReport;
  final StateEnum viewState;
  const OrderHeaderState(
      {required this.report, required this.viewState, required this.oldReport});
  factory OrderHeaderState.fromJson(Map<String, dynamic> json) {
    return OrderHeaderState(
      report: Report.fromJson(json['report']),
      viewState: StateEnum.values[json['viewState'] ?? 0],
      oldReport: Report.fromJson(json['oldReport']),
    );
  }
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
  Map<String, dynamic> toJson() {
    return {
      'report': report.toJson(),
      'viewState': viewState.index,
      'oldReport': oldReport.toJson(),
    };
  }

  @override
  List<Object?> get props => [viewState, report, oldReport];
}

class RestorableOrderHeaderState extends RestorableValue<OrderHeaderState> {
  final Report report;
  RestorableOrderHeaderState(this.report);
  @override
  OrderHeaderState createDefaultValue() => OrderHeaderState(
        report: report,
        viewState: StateEnum.idel,
        oldReport: report,
      );

  @override
  void didUpdateValue(OrderHeaderState? oldValue) {
    if (oldValue != null && oldValue != value) {
      notifyListeners();
    }
  }

  @override
  OrderHeaderState fromPrimitives(Object? data) {
    if (data != null) {
      var json = const JsonDecoder().convert(data.toString());
      return OrderHeaderState.fromJson(json);
    }
    return OrderHeaderState(
      report: report,
      viewState: StateEnum.idel,
      oldReport: report,
    );
  }

  @override
  Object? toPrimitives() {
    return const JsonEncoder().convert(value.toJson());
  }
}

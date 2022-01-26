part of 'order_header_bloc.dart';

class OrderHeaderState extends Equatable {
  final Report report;
  final StateEnum viewState;
  const OrderHeaderState({required this.report, required this.viewState});

  OrderHeaderState copyWith({Report? report, StateEnum? viewState}) =>
      OrderHeaderState(
        report: report ?? this.report,
        viewState: viewState ?? this.viewState,
      );
  @override
  List<Object?> get props => [viewState, report];
}

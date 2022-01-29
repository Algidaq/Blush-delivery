part of 'order_view_bloc.dart';

class OrderViewState extends Equatable {
  final StateEnum viewState;
  final Order order;
  final String message;
  const OrderViewState({
    required this.order,
    required this.viewState,
    this.message = '',
  });

  OrderViewState copyWith(
          {Order? order, StateEnum? viewState, String? message}) =>
      OrderViewState(
        order: order ?? this.order,
        viewState: viewState ?? this.viewState,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [viewState, order, message];
}

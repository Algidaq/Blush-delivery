part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final StateEnum viewState;
  final List<Order> orders;
  final String message;
  const OrdersState(
      {this.viewState = StateEnum.idel,
      this.orders = const [],
      this.message = ''});

  OrdersState copyWith(
      {StateEnum? viewState, List<Order>? orders, String? message = ''}) {
    return OrdersState(
      viewState: viewState ?? this.viewState,
      orders: orders ?? this.orders,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [viewState, orders, message];
}

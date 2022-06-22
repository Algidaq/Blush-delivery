part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final StateEnum viewState;
  final List<Order> orders;
  final String message;
  const OrdersState({
    this.viewState = StateEnum.idel,
    this.orders = const [],
    this.message = '',
  });

  factory OrdersState.fromJson(Map<String, dynamic> json) {
    List<dynamic> ordersJson = json['orders'] ?? const [];
    return OrdersState(
      viewState: StateEnum.values[json['viewState'] ?? 0],
      message: json['message'] ?? '',
      orders: ordersJson.map((e) => Order.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'viewState': viewState.index,
      'message': message,
      'orders': <Map<String, dynamic>>[...orders.map((e) => e.toJson())]
    };
  }

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

class RestorableOrdersState extends RestorableValue<OrdersState> {
  @override
  OrdersState createDefaultValue() => const OrdersState();

  @override
  void didUpdateValue(OrdersState? oldValue) {
    if (oldValue != null && oldValue != value) {
      notifyListeners();
    }
  }

  @override
  OrdersState fromPrimitives(Object? data) {
    if (data != null) {
      var jsonData = const JsonDecoder().convert(data.toString());
      return OrdersState.fromJson(jsonData);
    }
    return const OrdersState();
  }

  @override
  Object? toPrimitives() {
    var stringfyJsonData = const JsonEncoder().convert(value.toJson());
    return stringfyJsonData;
  }
}

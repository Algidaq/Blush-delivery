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

  // factory OrderViewState.fromJson(Map<String,dynin)
  factory OrderViewState.fromJson(Map<String, dynamic> json) {
    return OrderViewState(
      order: Order.fromJson(json['order']),
      viewState: StateEnum.values[json['viewState'] ?? 0],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'viewState': viewState.index,
      'order': order.toJson(),
      'message': message
    };
  }

  OrderViewState copyWith(
          {Order? order, StateEnum? viewState, String? message}) =>
      OrderViewState(
        order: order ?? this.order,
        viewState: viewState ?? this.viewState,
        message: message ?? this.message,
      );

  @override
  String toString() {
    var stringfiedJson = const JsonEncoder().convert(toJson());
    return stringfiedJson;
  }

  @override
  List<Object?> get props => [viewState, order, message];
}

class RestorableOrderState extends RestorableValue<OrderViewState> {
  final Order order;
  RestorableOrderState(this.order);
  @override
  OrderViewState createDefaultValue() =>
      OrderViewState(order: order, viewState: StateEnum.idel);

  @override
  void didUpdateValue(OrderViewState? oldValue) {
    if (oldValue != null && oldValue != value) {
      notifyListeners();
    }
  }

  @override
  OrderViewState fromPrimitives(Object? data) {
    if (data != null) {
      var json = const JsonDecoder().convert(data.toString());
      return OrderViewState.fromJson(json);
    }
    return OrderViewState(
      order: order,
      viewState: StateEnum.idel,
    );
  }

  @override
  Object? toPrimitives() {
    return value.toString();
  }
}

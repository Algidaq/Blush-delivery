part of 'orders_bloc.dart';

abstract class OrdersEvent {}

class FetchOrders extends OrdersEvent {}

class ReorderOrder extends OrdersEvent {
  final int oldIndex;
  final int newIndex;
  ReorderOrder(this.oldIndex, this.newIndex);
}

class EditOrder extends OrdersEvent {
  final Order order;
  EditOrder(this.order);
}

class RestoreState extends OrdersEvent {
  final OrdersState orderState;
  RestoreState(this.orderState);
}

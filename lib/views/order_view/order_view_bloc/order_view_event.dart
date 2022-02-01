part of 'order_view_bloc.dart';

abstract class OrderViewEvent {}

class AddNote extends OrderViewEvent {
  AddNote();
}

class RestoreOrderState extends OrderViewEvent {
  final OrderViewState orderViewState;
  RestoreOrderState(this.orderViewState);
}

part of 'order_header_bloc.dart';

abstract class OrderHeaderEvent {}

class ReloadReport extends OrderHeaderEvent {}

class RestoreOrderHeader extends OrderHeaderEvent {
  final OrderHeaderState state;
  RestoreOrderHeader(this.state);
}

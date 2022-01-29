import 'package:blush_delivery/models/order/order.dart';
import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  final Order order;
  const OrderView({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

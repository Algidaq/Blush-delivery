import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/views/order_view/widgets/order_billing.dart';
import 'package:blush_delivery/views/order_view/widgets/order_header.dart';
import 'package:blush_delivery/views/order_view/widgets/order_payment.dart';
import 'package:blush_delivery/views/order_view/widgets/products_list.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: AppText.title(
          'Order ${widget.order.formatedOrder}',
          color: Colors.white,
        ),
      ),
      backgroundColor: kcGrayMed,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          OrderHeader(order: widget.order),
          verticalSpaceSmall,
          ProductsList(order: widget.order),
          verticalSpaceSmall,
          OrderPayment(order: widget.order),
          verticalSpaceSmall,
          OrderBilling(order: widget.order)
        ],
      ),
    );
  }
}

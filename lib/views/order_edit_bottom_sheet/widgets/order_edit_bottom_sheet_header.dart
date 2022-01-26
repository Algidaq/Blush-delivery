import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:flutter/material.dart';

class OrderEditBottomSheetHeader extends StatelessWidget {
  final Order order;
  const OrderEditBottomSheetHeader({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.title('Edit ${order.formatedOrder}'),
        AppText.title('Total ${order.formatedTotal}')
      ],
    );
  }
}

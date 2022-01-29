import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/views/order_view/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final Order order;
  const ProductsList({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.subtitle2('Products'),
          verticalSpaceTiny,
          for (var i = 0; i < order.products.length; i++) ...[
            ProductItem(product: order.products[i]),
            if (i < order.products.length - 1) kListTileDivider,
          ]
        ],
      ),
    );
  }
}

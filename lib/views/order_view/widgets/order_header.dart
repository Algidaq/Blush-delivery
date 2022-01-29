import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/extensions/payment_method_ext.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/utils/utils.dart';
import 'package:blush_delivery/widgets/order_list_tile.dart/order_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderHeader extends StatelessWidget {
  final Order order;
  const OrderHeader({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(
        height: 84.0,
        width: double.maxFinite,
      ),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: order.paymentMethod == PaymentMethod.mbok ||
                order.paymentMethod == PaymentMethod.cashAndMobk,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: order.receipt.src != 'N/A'
                    ? order.receipt.src
                    : kImagePlaceHolder,
                width: 64.0,
                height: 64.0,
                fit: BoxFit.cover,
                placeholder: (_, url) => Shimmer(
                  child: Container(
                    color: Colors.white,
                  ),
                  gradient: const LinearGradient(
                      colors: [kcGrayDark, Colors.grey, kcGrayLight]),
                ),
              ),
            ),
          ),
          horizontalSpaceRegular,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.caption(
                order.createDate + '⚫️' + order.formatedOrder,
              ),
              const SizedBox(
                height: 2.0,
              ),
              AppText.subtitle2(order.billing.fullName),
              Row(
                children: [
                  OrderStatusChip(orderStatus: order.orderStatus),
                  horizontalSpaceSmall,
                  OrderStatusChip(
                    orderStatus: order.paymentMethod.title(S.of(context)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

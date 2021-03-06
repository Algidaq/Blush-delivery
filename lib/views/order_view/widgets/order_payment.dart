import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_button.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:blush_delivery/extensions/payment_method_ext.dart';

class OrderPayment extends StatelessWidget {
  final Order order;
  const OrderPayment({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.subtitle2(S.of(context).payment),
          const Divider(),
          _OrderPaymentNameValue(
            name: S.of(context).productTotal,
            value:
                formatCurrency((order.total - order.shippingTotal).toDouble()) +
                    S.of(context).sdg,
          ),
          verticalSpaceTiny,
          _OrderPaymentNameValue(
            name: S.of(context).shipping,
            value: order.formatedShippingTotal + S.of(context).sdg,
          ),
          verticalSpaceTiny,
          _OrderPaymentNameValue(
            name: S.of(context).shippingDetails,
            value: order.formatedTotal + S.of(context).sdg,
          ),
          const Divider(),
          if (order.paymentMethod == PaymentMethod.cash ||
              order.paymentMethod == PaymentMethod.mbok)
            _OrderPaymentNameValue(
              name: order.paymentMethod.title(S.of(context)),
              value: order.paymentMethod == PaymentMethod.cash
                  ? order.formatedCash
                  : order.formatedMbok,
            ),
          if (order.paymentMethod == PaymentMethod.cashAndMobk) ...[
            _OrderPaymentNameValue(
              name: PaymentMethod.cash.title(S.of(context)),
              value: order.formatedCash,
            ),
            verticalSpaceTiny,
            _OrderPaymentNameValue(
              name: PaymentMethod.mbok.title(S.of(context)),
              value: order.formatedMbok,
            ),
            verticalSpaceTiny,
          ],
        ],
      ),
    );
  }
}

class _OrderPaymentNameValue extends StatelessWidget {
  final String name;
  final String value;
  const _OrderPaymentNameValue(
      {Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [AppText.body2(name), AppText.body2(value)],
    );
  }
}

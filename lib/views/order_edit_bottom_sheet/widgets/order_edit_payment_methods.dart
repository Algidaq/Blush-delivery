import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/extensions/payment_method_ext.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OrderEditPaymentMethods extends StatelessWidget {
  const OrderEditPaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...PaymentMethod.values.map(
          (e) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReactiveRadioListTile<PaymentMethod>(
                value: e,
                formControlName: 'paymentMethod',
                title: AppText.body(e.title(S.of(context)).toUpperCase()),
                contentPadding: const EdgeInsets.all(0.0),
                selectedTileColor: kcAccentDark,
              ),
              kListTileDivider
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuAction { call, message }

class OrderBilling extends StatelessWidget {
  final Order order;
  const OrderBilling({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phones = [order.billing.phone, order.billing.phone2];
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText.subtitle2(S.of(context).shippingDetails),
          const Divider(),
          verticalSpaceTiny,
          Directionality(
            textDirection: TextDirection.rtl,
            child: AppText.body2(
                order.billing.city +
                    '\n' +
                    order.billing.state +
                    '\n' +
                    order.billing.address1 +
                    '\n' +
                    order.billing.address2,
                color: Colors.grey[600]),
          ),
          const Divider(),
          for (var i = 0; i < phones.length; i++) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body2(phones[i]),
                horizontalSpaceTiny,
                SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: PopupMenuButton<MenuAction>(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      size: 20.0,
                      color: kcPrimary,
                    ),
                    onSelected: (e) => handleActionSelected(e, phones[i]),
                    itemBuilder: (context) => MenuAction.values
                        .map(
                          (e) => PopupMenuItem<MenuAction>(
                            value: e,
                            child: AppText.body(getMenuText(context, e)),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            if (i < phones.length - 1) const Divider()
          ]
        ],
      ),
    );
  }

  String getMenuText(BuildContext context, MenuAction e) {
    switch (e) {
      case MenuAction.call:
        return S.of(context).call;
      case MenuAction.message:
        return S.of(context).message;
    }
  }

  Future<void> handleActionSelected(MenuAction value, String phone) async {
    var leading = value == MenuAction.call ? 'tel' : 'smsto';
    await launch('$leading:$phone');
  }
}

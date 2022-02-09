import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersCallActionSheet extends StatelessWidget {
  final Billing billing;
  const OrdersCallActionSheet({Key? key, required this.billing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.5,
      builder: (_, cont) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            controller: cont,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: AppText.subtitle(
                      S.of(context).primaryPhone,
                    ),
                    subtitle: AppText.body2(
                      billing.phone,
                      color: Colors.grey,
                    ),
                    trailing: const Icon(
                      Icons.phone,
                    ),
                    onTap: () => handleLaunch(billing.phone, context),
                  ),
                  kListTileDivider,
                  ListTile(
                    title: AppText.subtitle(S.of(context).secondaryPhone),
                    subtitle: AppText.body2(
                      billing.phone2,
                      color: Colors.grey,
                    ),
                    trailing: const Icon(
                      Icons.phone,
                    ),
                    onTap: () => handleLaunch(billing.phone2, context),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> handleLaunch(String phone, BuildContext context) async {
    await launch('tel:$phone');
    Navigator.of(context).pop();
  }
}

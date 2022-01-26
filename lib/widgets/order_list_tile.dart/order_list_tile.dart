import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/typedef/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderListTile extends StatelessWidget {
  final Order order;
  final TapReportCallBack? onTap;
  final TapReportCallBack? onLongPressed;
  final TapReportCallBack? onEdit;
  final TapReportCallBack? onCall;
  const OrderListTile(
      {Key? key,
      required this.order,
      this.onTap,
      this.onLongPressed,
      this.onEdit,
      this.onCall})
      : super(key: key);

  void handleOnLongPressed() => onLongPressed?.call(order);
  void handleOnTap() => onTap?.call(order);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: !order.isCompleted,
      startActionPane: ActionPane(motion: const BehindMotion(), children: [
        SlidableAction(
          onPressed: order.isCompleted ? null : (_) => onEdit?.call(order),
          label: S.of(context).edit,
          icon: Icons.edit,
          backgroundColor: kcAccentLight,
          foregroundColor: Colors.black,
        ),
        SlidableAction(
          onPressed: order.isCompleted ? null : (_) => onCall?.call(order),
          label: S.of(context).call,
          icon: Icons.call,
          backgroundColor: kcPrimary,
        ),
      ]),
      child: Material(
        child: ListTile(
          tileColor: Colors.white,
          // onLongPress: onLongPressed != null ? handleOnLongPressed : null,
          onTap: onTap != null ? handleOnTap : null,

          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(0.0)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.caption(order.createDate),
              AppText.subtitle(
                  order.formatedOrder + ' ' + order.billing.fullName),
            ],
          ),
          // isThreeLine: true,
          dense: true,
          // minVerticalPadding: ,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderStatusChip(orderStatus: order.orderStatus),
                horizontalSpaceSmall,
                AppText.caption(
                  order.billing.city.substring(
                    0,
                    order.billing.city.length >= 54
                        ? 54
                        : order.billing.city.length,
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpaceTiny,
              AppText.body2(order.formatedCash + ' SDG'),
              // OrderStatusChip(orderStatus: order.orderStatus),
            ],
          ),
        ),
      ),
    );
  }

  Color get textColor {
    switch (order.orderStatus) {
      case 'processing':
        return kcPrimary;
      case 'completed':
        return kcPrimary;

      default:
        return Colors.black;
    }
  }
}

class OrderStatusChip extends StatelessWidget {
  final String orderStatus;
  const OrderStatusChip({Key? key, required this.orderStatus})
      : super(key: key);

  Color get textColor {
    switch (orderStatus) {
      case 'processing':
        return Colors.white;

      default:
        return Colors.white;
    }
  }

  Color get backgroundColor {
    switch (orderStatus) {
      case 'processing':
        return kcPrimary;
      default:
        return kcPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: 28.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: kBorderRadiusLarge,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AppText.overline(
        orderStatus,
        color: textColor,
      ),
    );
  }
}

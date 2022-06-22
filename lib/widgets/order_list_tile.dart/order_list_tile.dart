import 'package:auto_size_text/auto_size_text.dart';
import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/extensions/payment_method_ext.dart';
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
  final TapReportCallBack? onNotes;
  final TapReportCallBack? onNotifie;
  const OrderListTile(
      {Key? key,
      required this.order,
      this.onTap,
      this.onLongPressed,
      this.onEdit,
      this.onCall,
      this.onNotes,
      this.onNotifie})
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
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          if (!order.isNotified)
            SlidableAction(
              onPressed: (_) => onNotifie?.call(order),
              icon: Icons.notification_add_rounded,
              label: S.of(context).notify,
              backgroundColor: kcPrimary,
            ),
          SlidableAction(
            onPressed: (_) => onNotes?.call(order),
            icon: Icons.chat_bubble_rounded,
            label: S.of(context).notes,
            backgroundColor: kcAccentLight,
          )
        ],
      ),
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
                if (order.isCompleted) horizontalSpaceTiny,
                if (order.isCompleted)
                  OrderStatusChip(
                      orderStatus: order.paymentMethod.title(S.of(context))),
                horizontalSpaceSmall,
                Expanded(
                  flex: 1,
                  child: AutoSizeText(
                    order.fullAddress.substring(
                      0,
                      order.fullAddress.length >= 48
                          ? 48
                          : order.fullAddress.length,
                    ),
                    style: Theme.of(context).textTheme.caption,
                    minFontSize: 11,
                    maxFontSize: 12,
                    maxLines: 1,
                    wrapWords: false,
                  ),
                )
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpaceTiny,
              AppText.body2(order.formatedTotal + ' SDG'),
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
      constraints: const BoxConstraints.tightFor(height: 24.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
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

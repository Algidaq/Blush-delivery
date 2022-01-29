import 'package:blush_delivery/app_bloc.dart';
import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderNotesSheet extends StatelessWidget {
  final Order order;
  const OrderNotesSheet({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.7,
      // initialChildSize: ,
      builder: (__, controller) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: Container(
          color: Colors.white,
          child: ListView.separated(
            controller: controller,
            padding: kListViewPadding,
            itemBuilder: (ctx, index) => index == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: AppText.subtitle('Notes ${order.formatedOrder}'),
                  )
                : _OrderNoteBubble(
                    index == 1
                        ? order.billing.city
                        : order.notes[index - 2].note,
                  ),
            itemCount: order.notes.length + 2,
            separatorBuilder: (ctx, index) => const SizedBox(height: 8.0),
          ),
        ),
      ),
    );
  }
}

class _OrderNoteBubble extends StatelessWidget {
  final String text;
  final Radius _radius;
  const _OrderNoteBubble(this.text, {Key? key})
      : _radius = const Radius.circular(24.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: context.read<AppBloc>().isArabic
          ? arabicBorderRadius
          : englishBorderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // margin: const EdgeInsets.only(bottom: 8.0),
        color: kcAccentLight,
        child: AppText.body(text),
      ),
    );
  }

  BorderRadius get arabicBorderRadius => BorderRadius.only(
      topLeft: _radius, bottomLeft: _radius, topRight: _radius);
  BorderRadius get englishBorderRadius => BorderRadius.only(
      topLeft: _radius, bottomRight: _radius, topRight: _radius);
}

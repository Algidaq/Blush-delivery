import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/widgets/order_list_tile.dart/order_loading_list_tile.dart';
import 'package:flutter/material.dart';

class OrdersListLoading extends StatelessWidget {
  const OrdersListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (_, index) => const OrderLoadingListTile(),
          childCount: 10),
    );
  }
}

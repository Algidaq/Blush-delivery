import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/widgets/report_progress.dart';
import 'package:flutter/material.dart';
part 'order_view_header_item.dart';

class OrderViewHeader extends StatelessWidget {
  final Report report;
  const OrderViewHeader({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportProgress(
            progress: report.progress,
            width: 64.0,
            height: 64.0,
          ),
          OrderHeaderItem(
            leadingIcon: Icons.bar_chart_rounded,
            leadingText: report.totalOrders,
            trailingIcon: Icons.attach_money_rounded,
            trailingText: report.formatedTotal,
          ),
          OrderHeaderItem(
            leadingIcon: Icons.sentiment_very_satisfied_rounded,
            leadingText: report.completedOrders,
            trailingIcon: Icons.payments_outlined,
            trailingText: report.formatedTotalCash,
          ),
          OrderHeaderItem(
            leadingIcon: Icons.sentiment_very_dissatisfied,
            leadingText: report.incompleteOrders,
            trailingIcon: Icons.mobile_friendly_outlined,
            trailingText: report.formatedTotalCash,
          ),
        ],
      ),
    );
  }
}

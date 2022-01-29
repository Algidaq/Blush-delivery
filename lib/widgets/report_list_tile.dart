import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/widgets/report_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportListTile extends StatelessWidget {
  final Report report;
  final void Function(Report report)? onTap;
  const ReportListTile({Key? key, required this.report, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      // shape: const RoundedRectangleBorder(borderRadius: kBorderRadiusSemiLarge),
      style: ListTileStyle.list,
      onTap: onTap != null ? handleOnTap : null,
      enableFeedback: false,
      dense: true,
      tileColor: Colors.white,
      leading: Hero(
        tag: 'ReportProgress_${report.date}',
        child: ReportProgress(
          progress: report.progress,
          height: 48.0,
          width: 48.0,
        ),
      ),
      title: AppText.subtitle(report.date),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _ReportData(
            data: report.totalOrders,
            icon: CupertinoIcons.doc_chart,
          ),
          horizontalSpaceSmall,
          _ReportData(
            data: report.completedOrders,
            icon: CupertinoIcons.doc_checkmark,
          ),
          horizontalSpaceSmall,
          _ReportData(
              data: report.incompleteOrders,
              icon: CupertinoIcons.arrow_down_doc)
        ],
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.body(NumberFormat('#,###.#').format(report.total) + ' SDG'),
        ],
      ),
    );
  }

  void handleOnTap() => onTap?.call(report);
}

class _ReportData extends StatelessWidget {
  final String data;
  final IconData icon;
  final Color color;
  const _ReportData(
      {Key? key,
      required this.data,
      required this.icon,
      this.color = kcPrimary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 16.0,
        ),
        AppText.subtitle2(
          data,
          color: Colors.grey[600],
        )
      ],
    );
  }
}

import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReportListTile extends StatelessWidget {
  final Report report;
  const ReportListTile({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      shape: const RoundedRectangleBorder(borderRadius: kBorderRadiusSemiLarge),
      style: ListTileStyle.list,
      onTap: () {},
      enableFeedback: false,
      dense: true,
      tileColor: Colors.white,
      leading: _ReportProgress(
        progress: report.progress,
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
          AppText.body(NumberFormat('#,###.#').format(report.total)),
          const Icon(
            CupertinoIcons.money_dollar,
            color: kcAccentMed,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _ReportProgress extends StatelessWidget {
  final num progress;
  const _ReportProgress({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 48.0,
        height: 48.0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: AppText.body(
                progress.toInt().toString() + '%',
              ),
            ),
            SizedBox(
              height: 48.0,
              width: 48.0,
              child: TweenAnimationBuilder<double>(
                tween:
                    Tween<double>(begin: 0.0, end: progress.toDouble() / 100),
                duration: const Duration(seconds: 3),
                builder: (_, value, __) => CircularProgressIndicator(
                  value: value,
                  color: kcAccentLight,
                  backgroundColor: kcPrimary,
                  strokeWidth: 6.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
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

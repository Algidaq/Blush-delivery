import 'package:blush_delivery/widgets/report_loading_list_tile.dart';
import 'package:flutter/material.dart';

class ReportsListLoading extends StatelessWidget {
  const ReportsListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (ctx, index) => const ReportLoadingListTile(),
        separatorBuilder: (_, index) => Divider(
              color: Colors.grey[350],
              indent: 16.0,
              endIndent: 16.0,
              height: 1.0,
            ),
        itemCount: 10);
  }
}

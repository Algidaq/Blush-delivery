import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/widgets/report_loading_list_tile.dart';
import 'package:flutter/material.dart';

class ReportsListLoading extends StatelessWidget {
  const ReportsListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: kListViewPadding,
      sliver: SliverList(
          delegate: SliverChildListDelegate.fixed(List.generate(
              10,
              (index) => const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: ReportLoadingListTile(),
                  )))),
    );
  }
}

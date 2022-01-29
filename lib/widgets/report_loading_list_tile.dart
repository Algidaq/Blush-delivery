import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReportLoadingListTile extends StatelessWidget {
  const ReportLoadingListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      // shape: const RoundedRectangleBorder(borderRadius: kBorderRadiusSemiLarge),
      tileColor: Colors.white,
      style: ListTileStyle.list,
      leading: Shimmer.fromColors(
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: const BoxConstraints.tightFor(width: 48.0, height: 48.0),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        ),
        baseColor: kcGrayLight,
        highlightColor: kcGrayDark,
      ),
      title: Shimmer.fromColors(
        child: SizedBox(
          width: 54.0,
          height: 16.0,
          child: Container(
            width: 54.0,
            color: kcGrayMed,
          ),
        ),
        baseColor: kcGrayLight,
        highlightColor: kcGrayDark,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Shimmer.fromColors(
            child: Container(
                color: kcGrayMed,
                constraints:
                    const BoxConstraints.tightFor(width: 24.0, height: 16.0)),
            baseColor: kcGrayLight,
            highlightColor: kcGrayDark,
          ),
          horizontalSpaceSmall,
          Shimmer.fromColors(
            child: Container(
                color: kcGrayMed,
                constraints:
                    const BoxConstraints.tightFor(width: 24.0, height: 16.0)),
            baseColor: kcGrayLight,
            highlightColor: kcGrayDark,
          ),
          horizontalSpaceSmall,
          Shimmer.fromColors(
            child: Container(
                color: kcGrayMed,
                constraints:
                    const BoxConstraints.tightFor(width: 24.0, height: 16.0)),
            baseColor: kcGrayLight,
            highlightColor: kcGrayDark,
          ),
        ],
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            child: Container(
                color: kcGrayMed,
                constraints:
                    const BoxConstraints.tightFor(width: 24.0, height: 16.0)),
            baseColor: kcGrayLight,
            highlightColor: kcGrayDark,
          ),
        ],
      ),
    );
  }
}

import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderLoadingListTile extends StatelessWidget {
  const OrderLoadingListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer(
            child: SizedBox(
              width: 40.0,
              height: 15.0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: kBorderRadiusTiny,
                  color: kcGrayDark,
                ),
              ),
            ),
            gradient: const LinearGradient(colors: [kcGrayDark, kcGrayMed]),
          ),
          const SizedBox(height: 2),
          Shimmer(
            child: SizedBox(
              width: double.maxFinite,
              height: 21.0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: kBorderRadiusTiny,
                  color: kcGrayDark,
                ),
              ),
            ),
            gradient: const LinearGradient(colors: [kcGrayDark, kcGrayMed]),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Shimmer(
          child: SizedBox(
            width: 100.0,
            height: 16.0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: kBorderRadiusTiny,
                color: kcGrayDark,
              ),
            ),
          ),
          gradient: const LinearGradient(colors: [kcGrayDark, kcGrayMed]),
        ),
      ),
      trailing: Shimmer(
        child: SizedBox(
          width: 100.0,
          height: 21.0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: kBorderRadiusTiny,
              color: kcGrayDark,
            ),
          ),
        ),
        gradient: const LinearGradient(colors: [kcGrayDark, kcGrayMed]),
      ),
    );
  }
}

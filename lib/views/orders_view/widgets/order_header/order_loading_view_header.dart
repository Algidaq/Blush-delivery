import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderLoadingViewHeader extends StatelessWidget {
  const OrderLoadingViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const loadingGradient = LinearGradient(colors: [kcGrayDark, kcGrayMed]);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer(
            gradient: loadingGradient,
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 64.0,
                height: 64.0,
                child: Container(
                  color: kcGrayLight,
                ),
              ),
            ),
          ),
          const _OrderHeaderLoadingItem(),
          const _OrderHeaderLoadingItem(),
          const _OrderHeaderLoadingItem(),
        ],
      ),
    );
  }
}

class _OrderHeaderLoadingItem extends StatelessWidget {
  const _OrderHeaderLoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const loadingGradient = LinearGradient(colors: [kcGrayDark, kcGrayMed]);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Shimmer(
                gradient: loadingGradient,
                child: SizedBox(
                  width: 32.0,
                  height: 16.0,
                  child: Container(
                    color: kcGrayDark,
                  ),
                ))
          ],
        ),
        verticalSpaceRegular,
        Row(
          children: [
            Shimmer(
                gradient: loadingGradient,
                child: SizedBox(
                  width: 32.0,
                  height: 16.0,
                  child: Container(
                    color: kcGrayDark,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.tightFor(
            height: 80.0, width: double.maxFinite),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 64.0,
                height: 64.0,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => Shimmer(
                  child: Container(
                    color: kcGrayDark,
                  ),
                  gradient: const LinearGradient(
                    colors: [kcGrayDark, Colors.grey],
                  ),
                ),
              ),
            ),
            horizontalSpaceRegular,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AutoSizeText(
                          product.name,
                          style: kBody2Style,
                          maxFontSize: 14.0,
                          minFontSize: 12.0,
                          maxLines: 1,
                        ),
                      ),
                      AppText.body2(product.fromatedTotal),
                    ],
                  ),
                  AppText.caption(
                    product.quantity.toString() + ' X ' + product.foramtedPrice,
                  )
                ],
              ),
            )
          ],
        ));
  }
}

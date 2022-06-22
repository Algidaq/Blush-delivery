import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReceiptView extends StatefulWidget {
  final Receipt receipt;
  const ReceiptView({Key? key, required this.receipt}) : super(key: key);

  @override
  State<ReceiptView> createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> with RestorationMixin {
  final RestorableString _receiptRestorableState = RestorableString('');
  late final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: handleBackNavigation,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kcPrimary,
            ),
          ),
        ),
        backgroundColor: kcGrayDark,
        body: InteractiveViewer(
            child: Hero(
          tag: 'receipt_tag',
          child: CachedNetworkImage(
            imageUrl: imageSrc,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
        )),
      ),
    );
  }

  @override
  String? get restorationId => 'receipt_view';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_receiptRestorableState, 'receipt_src');
    if (_receiptRestorableState.value.isNotEmpty) {
      setState(() {
        imageSrc = _receiptRestorableState.value;
      });
    } else {
      AppLogger.e(widget.receipt);
      setState(() {
        imageSrc = widget.receipt.src;
        _receiptRestorableState.value = imageSrc;
      });
    }
  }

  @override
  void dispose() {
    _receiptRestorableState.dispose();
    super.dispose();
  }

  Future<void> handleBackNavigation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Navigator.of(context).pop();
  }
}

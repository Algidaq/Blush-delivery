import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_input.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/services/edit_order_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/order_edit_bottom_sheet_bloc.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/widgets/order_edit_bottom_sheet_header.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/widgets/order_edit_form.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/widgets/order_edit_payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OrderEditBottomSheet extends StatefulWidget {
  final Order order;
  const OrderEditBottomSheet({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderEditBottomSheet> createState() => _OrderEditBottomSheetState();
}

class _OrderEditBottomSheetState extends State<OrderEditBottomSheet> {
  late final OrderEditBottomSheetBloc bloc;
  @override
  void initState() {
    bloc = OrderEditBottomSheetBloc(widget.order, EditOrderService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.6,
      initialChildSize: 0.7,
      builder: (_, cot) => ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ReactiveForm(
            formGroup: bloc.formGroup,
            child: ListView(
              controller: cot,
              shrinkWrap: true,
              padding: kListViewPadding,
              children: [
                OrderEditBottomSheetHeader(order: widget.order),
                verticalSpaceSmall,
                const AppText.subtitle('Select Payment Method'),
                verticalSpaceSmall,
                const OrderEditPaymentMethods(),
                verticalSpaceSmall,
                ReactiveFormConsumer(
                  child:
                      const AppText.subtitle('Please Complete Insert Values'),
                  builder: (_, form, child) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    // height: bloc.showReceipt ? 204.0 : 0.0,
                    child: !bloc.showReceipt
                        ? const SizedBox()
                        : OrderEditForm(
                            bloc: bloc,
                            form: form,
                            child: child,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
    AppLogger.e(this, 'On dispose');
  }
}

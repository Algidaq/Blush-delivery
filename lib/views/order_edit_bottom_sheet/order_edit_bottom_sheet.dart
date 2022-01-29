import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_input.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/services/edit_order_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/order_edit_bottom_sheet_bloc.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/widgets/order_edit_bottom_sheet_header.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/widgets/order_edit_form.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/widgets/order_edit_payment_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<OrderEditBottomSheetBloc, OrderEditBottomSheetState>(
      listener: handleNavigation,
      bloc: bloc,
      child: DraggableScrollableSheet(
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
                  AppText.subtitle(
                      S.of(context).select + ' ' + S.of(context).paymentMethod),
                  verticalSpaceSmall,
                  const OrderEditPaymentMethods(),
                  verticalSpaceSmall,
                  ReactiveFormConsumer(
                    // child: AppText.subtitle('Please Complete Insert Values'),
                    builder: (_, form, child) => Column(
                      children: [
                        OrderEditForm(
                          bloc: bloc,
                          form: form,
                          child: child,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

  void handleNavigation(BuildContext context, OrderEditBottomSheetState state) {
    if (state.viewState == StateEnum.success ||
        state.viewState == StateEnum.error) {
      Navigator.of(context).pop(state.updatedOrder);
    }
  }
}

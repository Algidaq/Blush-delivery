import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_button.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/services/edit_order_service.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_view/order_view_bloc/order_view_bloc.dart';
import 'package:blush_delivery/views/order_view/widgets/order_billing.dart';
import 'package:blush_delivery/views/order_view/widgets/order_header.dart';
import 'package:blush_delivery/views/order_view/widgets/order_note.dart';
import 'package:blush_delivery/views/order_view/widgets/order_payment.dart';
import 'package:blush_delivery/views/order_view/widgets/products_list.dart';
import 'package:blush_delivery/views/orders_view/orders_bloc/orders_bloc.dart';
import 'package:blush_delivery/views/orders_view/widgets/order_notes_sheet/order_notes_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatefulWidget {
  final Order order;
  const OrderView({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with RestorationMixin {
  late final OrderViewBloc bloc;
  late final RestorableOrderState restorableOrderState;
  @override
  void initState() {
    bloc = OrderViewBloc(order: widget.order, service: EditOrderService());
    restorableOrderState = RestorableOrderState(widget.order);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // OrdersBloc test = context.read();
    return WillPopScope(
      onWillPop: handlePopScope,
      child: Scaffold(
        appBar: AppBar(
          title: AppText.title(
            'Order',
            color: Colors.white,
          ),
          leading: BlocConsumer<OrderViewBloc, OrderViewState>(
            bloc: bloc,
            listener: showSnackBar,
            builder: (context, state) => IconButton(
              onPressed: state.viewState == StateEnum.busy
                  ? null
                  : handleNavigationBack,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: kcGrayMed,
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: [
            OrderHeader(
              order: bloc.state.order,
              onReceiptTap: handleOnReceiptTap,
            ),
            verticalSpaceSmall,
            ProductsList(order: bloc.state.order),
            verticalSpaceSmall,
            OrderPayment(order: bloc.state.order),
            verticalSpaceSmall,
            OrderBilling(order: bloc.state.order),
            verticalSpaceSmall,
            OrderNote(
              bloc: bloc,
              onAddNotes: handleAddNote,
              onSeeAllNotes: handleSeeAllNotes,
            )
          ],
        ),
      ),
    );
  }

  void handleSeeAllNotes() {
    showModalBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 104.0),
      context: context,
      builder: (_) => OrderNotesSheet(order: bloc.state.order),
    );
  }

  Future<bool> handlePopScope() async {
    return !(bloc.state.viewState != StateEnum.busy);
  }

  void showSnackBar(BuildContext context, OrderViewState state) {
    if (state.viewState == StateEnum.error) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: AppText.body2(state.message),
        ));
    }
    restorableOrderState.value = state;
  }

  void handleNavigationBack() {
    Navigator.of(context).pop(bloc.state.order);
  }

  void handleAddNote() {
    bloc.add(AddNote());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void handleOnReceiptTap() {
    Navigator.of(context).restorablePushNamed(
      kReceiptRoute,
      arguments: bloc.state.order.receipt.toString(),
    );
  }

  @override
  String? get restorationId => 'order_view';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(restorableOrderState, 'order_view_state');
    if (oldBucket != null && oldBucket.contains('order_view_state')) {}
  }
}

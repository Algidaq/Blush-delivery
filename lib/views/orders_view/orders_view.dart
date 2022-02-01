import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/order_edit_bottom_sheet.dart';
import 'package:blush_delivery/views/orders_view/orders_bloc/orders_bloc.dart';
import 'package:blush_delivery/views/orders_view/widgets/order_header/order_header_bloc/order_header_bloc.dart';
import 'package:blush_delivery/views/orders_view/widgets/order_notes_sheet/order_notes_sheet.dart';
import 'package:blush_delivery/views/orders_view/widgets/orders_call_action_sheet.dart';
import 'package:blush_delivery/views/orders_view/widgets/orders_list_loading.dart';
import 'package:blush_delivery/widgets/order_list_tile.dart/order_list_tile.dart';
import 'package:blush_delivery/widgets/sliver_center.dart';
import 'package:blush_delivery/widgets/state_switch.dart';
import 'package:blush_delivery/widgets/text_with_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/order_header/order_view_header.dart';

class OrdersView extends StatefulWidget {
  final Report report;
  const OrdersView({Key? key, required this.report}) : super(key: key);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> with RestorationMixin {
  late final OrdersBloc bloc;
  final listKey = GlobalKey<SliverReorderableListState>();
  final RestorableOrdersState _restorableOrderState = RestorableOrdersState();
  late final RestorableRouteFuture<Order?> _restorableOrderRoute;
  @override
  void initState() {
    bloc = context.read();
    _restorableOrderRoute = RestorableRouteFuture<Order?>(
      onPresent: (navigator, arguments) =>
          navigator.restorablePushNamed(kOrderRoute, arguments: arguments),
      onComplete: handleEditComplete,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppText.title(
            '${widget.report.date} ${S.of(context).orders}',
            color: Colors.white,
          ),
          actions: [kwSettingsIcon],
          leading: IconButton(
            onPressed: handleBackNavigation,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kcGrayLight,
        body: RefreshIndicator(
          onRefresh: handleRefresh,
          color: kcPrimary,
          displacement: 0.0,
          child: CustomScrollView(
            key: UniqueKey(),
            slivers: [
              const OrderViewHeader(),
              BlocConsumer<OrdersBloc, OrdersState>(
                listener: handleStateRestoration,
                builder: (_, state) {
                  return StateSwitch(
                    viewState: state.viewState,
                    busy: const OrdersListLoading(),
                    success: SliverReorderableList(
                      key: listKey,
                      itemBuilder: (__, index) => ReorderableDragStartListener(
                        index: index,
                        key: ValueKey<int>(index),
                        child: OrderListTile(
                          key: ValueKey<String>(state.orders[index].id),

                          order: state.orders[index],
                          onEdit: handleOrderEdit,
                          // onLongPressed: handleOrderLongPress,
                          onTap: handleOrderTap,
                          onCall: handleCall,
                          onNotes: showNotesBottomSheet,
                          onNotifie: bloc.notifieCustomer,
                        ),
                      ),
                      itemCount: state.orders.length,
                      onReorder: handleReorder,
                      // itemExtent: 104.0,
                    ),
                    error: SliverCenter(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 104.0),
                      child: TextWithButton(
                        text: state.message,
                        buttonText: S.of(_).reload,
                        textColor: Colors.red,
                        onTap: handleRefresh,
                      ),
                    ),
                    idel: SliverCenter(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 104.0),
                      child: TextWithButton(
                        text: S.of(_).noOrders,
                        buttonText: S.of(_).reload,
                        onTap: handleRefresh,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Future<void> handleRefresh() async {
    bloc.add(FetchOrders());
  }

  void handleOrderLongPress(Order order) {}

  Future<void> handleOrderTap(Order order) async {
    _restorableOrderRoute.present(order.toString());

    // RestorableRouteFuture<Order>(onPresent: (navigator,arguments)=>navigator.restorablePushNamed(k))
  }

  Future<void> handleOrderEdit(Order order) async {
    var updatedOrder = await showModalBottomSheet<Order>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height - 104.0),
      enableDrag: true,
      isDismissible: false,
      builder: (context) => OrderEditBottomSheet(order: order),
    );
    if (updatedOrder != null) {
      bloc.add(EditOrder(updatedOrder));
      context.read<OrderHeaderBloc>().add(ReloadReport());
    }
  }

  void handleReorder(int oldIndex, int newIndex) {
    bloc.add(ReorderOrder(oldIndex, newIndex));
  }

  void handleCall(Order order) {
    AppLogger.d('on Call $order');
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      context: context,
      builder: (_) => OrdersCallActionSheet(
        billing: order.billing,
      ),
    );
  }

  void showNotesBottomSheet(Order order) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (_) => OrderNotesSheet(order: order),
    );
  }

  void handleStateRestoration(BuildContext context, OrdersState state) {
    _restorableOrderState.value = state;
  }

  @override
  String? get restorationId => 'orders_view';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restorableOrderState, 'orders_view_state');
    registerForRestoration(
        _restorableOrderRoute, 'order_view_restorable_route');
    if (_restorableOrderState.value.viewState == StateEnum.idel) {
      bloc.add(FetchOrders());
    } else {
      bloc.add(RestoreState(_restorableOrderState.value));
    }
  }

  Future<void> handleBackNavigation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).pop();
  }

  void handleEditComplete(Order? result) {
    AppLogger.i('update order state');
    bloc.add(EditOrder(result!));
  }

  @override
  void dispose() {
    _restorableOrderRoute.dispose();
    _restorableOrderState.dispose();
    super.dispose();
  }
}

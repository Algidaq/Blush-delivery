import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/views/orders_view/orders_bloc/orders_bloc.dart';
import 'package:blush_delivery/views/orders_view/widgets/orders_list_loading.dart';
import 'package:blush_delivery/widgets/order_list_tile.dart/order_list_tile.dart';
import 'package:blush_delivery/widgets/state_switch.dart';
import 'package:blush_delivery/widgets/text_with_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatefulWidget {
  final Report report;
  const OrdersView({Key? key, required this.report}) : super(key: key);

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  late final OrdersBloc bloc;
  @override
  void initState() {
    bloc = context.read()..add(FetchOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.title(
          '${widget.report.date} Orders',
          color: Colors.white,
        ),
      ),
      backgroundColor: kcGrayLight,
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (_, state) => StateSwitch(
            viewState: state.viewState,
            busy: const OrdersListLoading(),
            success: ListView.separated(
              itemBuilder: (__, index) => OrderListTile(
                order: state.orders[index],
                onEdit: handleOrderEdit,
                onTap: handleOrderTap,
                onLongPressed: handleOrderLongPress,
              ),
              separatorBuilder: (__, index) => kListTileDivider,
              itemCount: state.orders.length,
            ),
            error: SingleChildScrollView(
              child: Center(
                child: TextWithButton(
                  text: state.message,
                  buttonText: S.of(_).reload,
                  textColor: Colors.red,
                  onTap: handleRefresh,
                ),
              ),
            ),
            idel: TextWithButton(
              text: S.of(_).noOrders,
              buttonText: S.of(_).reload,
              onTap: handleRefresh,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleRefresh() async {
    bloc.add(FetchOrders());
  }

  void handleOrderLongPress(Order order) {}

  void handleOrderTap(Order order) {}

  void handleOrderEdit(Order order) {}
}

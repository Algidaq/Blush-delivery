import 'package:blush_delivery/interfaces/i_report_orders_service.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/services/base_service.dart';

class ReportOrdersService extends BaseService implements IReportOrdersService {
  @override
  String get path => '/driver/orders';
  @override
  Future<List<Order>> getReportOrders({required String reportDate}) async {
    try {
      var res = await get(params: '/$reportDate');
      List<dynamic> ordersJson = res.data ?? [];
      return ordersJson.map((orderJson) => Order.fromJson(orderJson)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:blush_delivery/models/order/order.dart';

abstract class IReportOrdersService {
  Future<List<Order>> getReportOrders({required String reportDate});
}

import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/services/auth_service/auth_service_req_model.dart';
import 'package:blush_delivery/services/report_orders_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

import '../services_mocks/driver_report_service_mock.dart';

void main() {
  group('ReportOrdersService Test-', () {
    group('Mock Test-', () {
      test('When get ordres is called on mock service', () async {
        //Arrange
        var service = ReportOrdersServiceMock();
        //Act
        var data = await service.getReportOrders(reportDate: '14-2-2021');
        //Assert
        expect(data, isA<List<Order>>());
        AppLogger.i(data.first);
      });
    });

    ///This group test is totally depending on login data and date of the report if Exits
    group('RealService Test-', () {
      setUp(() async {
        await AuthService().login(
            AuthServiceReqModel(phone: '0902296931', password: 'Algidaq33@'));
      });
      test('When get orders should returns a list of orders', () async {
        //Arrange
        var service = ReportOrdersService();
        //Act
        var orders = await service.getReportOrders(reportDate: '14-01-2022');
        //Assert
        // expect(orders.isNotEmpty, matcher)
        AppLogger.d(orders);
      });
    });
  });
}

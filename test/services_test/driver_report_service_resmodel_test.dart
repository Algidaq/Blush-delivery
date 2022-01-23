import 'package:blush_delivery/utils/app_mocks.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';

void main() {
  group('DriverReportResModel Test-', () {
    group('Construction Test', () {
      test('When Constructed with valid json data', () async {
        //Arrange
        var headers = Headers();
        headers.set('total-pages', '1');
        headers.set('count', '2');
        //Act
        var reportRes =
            DriverReportResModel.fromJson(AppMocks.kReportListMock, headers);
        //Assert
        expect(reportRes.reports.length, 2);
        expect(reportRes.reports[0].totalOrders, "2");
        expect(reportRes.count, 2);
        expect(reportRes.totalPages, 1);
      });

      test(
          'When Constrected with invalid headers name, totalPages should be 1, count 10',
          () async {
        var headers = Headers();
        headers.set('total-page', '');
        headers.set('count', '');
        //Act
        var reportRes =
            DriverReportResModel.fromJson(AppMocks.kReportListMock, headers);
        //Assert
        expect(reportRes.reports.length, 2);
        expect(reportRes.reports[0].totalOrders, "2");
        expect(reportRes.count, 10);
        expect(reportRes.totalPages, 1);
      });
    });
  });
}

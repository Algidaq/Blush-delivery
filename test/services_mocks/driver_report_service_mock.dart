import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/interfaces/i_report_orders_service.dart';
import 'package:blush_delivery/models/app_exception.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/app_mocks.dart';
import 'package:dio/dio.dart';

class DriverReportSerivceMock implements IDriverReportService {
  @override
  Future<DriverReportResModel> getDriverReports(
      {DriverReportReqModel? queryParams}) async {
    AppLogger.i('loadding Data from Mock $queryParams');
    await Future.delayed(const Duration(seconds: 2));
    var headers = Headers();
    var mocks = [];
    if (queryParams != null && queryParams.page > 2) {
      mocks = [];
    } else {
      headers.set('total-pages', '3');
      headers.set('count', '10');
      mocks.addAll(AppMocks.kReportListMock);
    }

    return DriverReportResModel.fromJson(mocks, headers);
  }

  @override
  Future<Report> getReportByDate({required String date}) {
    // TODO: implement getReportByDate
    throw UnimplementedError();
  }
}

class DriverServiceErrorMock implements IDriverReportService {
  @override
  Future<DriverReportResModel> getDriverReports(
      {DriverReportReqModel? queryParams}) {
    Future.delayed(const Duration(seconds: 2));
    throw AppException('UnAble to reterive application Data');
  }

  @override
  Future<Report> getReportByDate({required String date}) {
    // TODO: implement getReportByDate
    throw UnimplementedError();
  }
}

class ReportOrdersServiceMock implements IReportOrdersService {
  @override
  Future<List<Order>> getReportOrders({required String reportDate}) async {
    await Future.delayed(const Duration(seconds: 2));
    return List<Order>.generate(
      10,
      (index) => Order.fromJson(AppMocks.kOrderMock),
    );
  }

  @override
  Future<Order> notifieCustomer(String id) {
    // TODO: implement notifieCustomer
    throw UnimplementedError();
  }
}

class ReportOrdersServiceErrorMock implements IReportOrdersService {
  @override
  Future<List<Order>> getReportOrders({required String reportDate}) {
    throw UnimplementedError();
  }

  @override
  Future<Order> notifieCustomer(String id) {
    // TODO: implement notifieCustomer
    throw UnimplementedError();
  }
}

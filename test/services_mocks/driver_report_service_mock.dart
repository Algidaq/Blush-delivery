import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/models/app_exception.dart';
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
}

class DriverServiceErrorMock implements IDriverReportService {
  @override
  Future<DriverReportResModel> getDriverReports(
      {DriverReportReqModel? queryParams}) {
    Future.delayed(const Duration(seconds: 2));
    throw AppException('UnAble to reterive application Data');
  }
}

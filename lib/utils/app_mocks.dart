import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:dio/dio.dart';

class AppMocks {
  static const kReportMock = {
    "totalOrders": "2",
    "totalCash": 1990,
    "totalMbok": 0,
    "total": 1990,
    "completedOrders": "1",
    "incompletedOrders": "1",
    "isVerified": false,
    "shippingTotal": 0,
    "date": "14-01-2022",
    "driver": {
      "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
      "firstName": "Yousf",
      "lastName": "Test",
      "phoneNumber": "0902296931",
      "role": "driver"
    }
  };
  static const kReportListMock = [
    {
      "totalOrders": "2",
      "totalCash": 1990,
      "totalMbok": 0,
      "total": 1990,
      "completedOrders": "1",
      "incompletedOrders": "1",
      "isVerified": false,
      "shippingTotal": 0,
      "date": "14-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "1",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "30",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "4",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "10",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "5",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "4",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "7",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
    {
      "totalOrders": "1",
      "totalCash": 6330,
      "totalMbok": 0,
      "total": 6330,
      "completedOrders": "1",
      "incompletedOrders": "0",
      "isVerified": true,
      "shippingTotal": 0,
      "date": "12-01-2022",
      "driver": {
        "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
        "firstName": "Yousf",
        "lastName": "Test",
        "phoneNumber": "0902296931",
        "role": "driver"
      }
    },
  ];
}

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

import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/utils.dart';
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
  static const kOrderMock = {
    "id": "f9954c48-440a-4a60-b209-34fd0a249482",
    "orderId": 7770,
    "date": "14-01-2022",
    "createDate": "2021-03-19T01:23:46",
    "customerId": 8609,
    "total": 1990,
    "shippingTotal": 0,
    "orderStatus": "completed",
    "isAssigned": true,
    "cash": 1990,
    "mbok": 0,
    "paymentMethod": 0,
    "isVerified": true,
    "driver": {
      "id": "e36b412d-b7cd-41d9-99fe-c693e406a94b",
      "firstName": "Yousf",
      "lastName": "Test",
      "phoneNumber": "0902296931",
      "role": "driver",
      "profileImage": null,
      "create_date": "2022-01-13T06:15:05.596Z",
      "update_date": "2022-01-13T06:15:05.596Z"
    },
    "billing": {
      "id": "64fc621d-80e7-4618-b244-60e76a7cd06a",
      "firstName": "وصال",
      "lastName": "صولا",
      "address1": "N/A",
      "address2": "N/A",
      "city": "معموره مربع ٧١..شارع رقم ٧",
      "state": "Khartoum",
      "primaryPhone": "0923884790",
      "secondaryPhone": "0929843168"
    },
    "lineItems": [
      {
        "id": "37ca3214-7237-4949-a006-e0aca02d1c5b",
        "name":
            "Nivea nourishing cocoa body lotion 400ml |  لوشن الجسم بالكاكاو المغذي من نيفيا 400 مل",
        "productId": 7480,
        "varationId": 0,
        "quantity": 2,
        "total": 1500,
        "productPrice": 750,
        "productImage":
            "https://i1.wp.com/test.blush-sd.com/wp/wp-content/uploads/2020/08/32.jpg?fit=608%2C1079&ssl=1"
      },
      {
        "id": "7323cc41-5fc0-4609-a84f-217cff3b137f",
        "name":
            "SPRING MY WAY YOGURT &amp; HONEY | ماي واي مزيل العرق كريم للللجنسين",
        "productId": 5439,
        "varationId": 0,
        "quantity": 1,
        "total": 300,
        "productPrice": 300,
        "productImage":
            "https://i0.wp.com/test.blush-sd.com/wp/wp-content/uploads/2020/12/1038.jpg?fit=608%2C1079&ssl=1"
      },
      {
        "id": "cf5236b8-fd76-403f-bf9d-2e4e9e93bdd3",
        "name": "Johnson's Baby Powder 50gm",
        "productId": 15530,
        "varationId": 0,
        "quantity": 1,
        "total": 190,
        "productPrice": 190,
        "productImage":
            "https://i1.wp.com/test.blush-sd.com/wp/wp-content/uploads/2020/08/8-2.jpg?fit=608%2C1079&ssl=1"
      }
    ],
    "notes": [
      {
        "note": "First not on to this id",
        "id": "0fc50912-e5b8-493b-af07-6fa474bee6a3",
        "createDate": "2022-01-23T11:05:32.999Z"
      }
    ],
    "receipt": {
      'id': '0fc50912-e5b8-493b-af07-6fa474bee6a3',
      'src': kImagePlaceHolder
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

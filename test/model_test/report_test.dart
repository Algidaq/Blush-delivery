import 'package:blush_delivery/models/report.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Construction Test-', () {
    test('When constructed with a valid data', () async {
      //Arrange
      var data = {
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
      //Act
      var report = Report.fromJson(data);
      //Assert
      expect(report.date, data['date']);
      expect(report.totalCash, data['totalCash']);
    });
  });
}

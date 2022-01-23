import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/models/order.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Order model Test', () {
    group('Construction Test-', () {
      test('When constructed with valid data', () async {
        //Arrange
        var data = {
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
          "isVerified": true
        };
        //Act
        var order = Order.fromJson(data);
        //Assert
        expect(order.id, data['id']);
        expect(order.orderId, data['orderId']);
        expect(order.reportDate, data['date']);
        AppLogger.i(order.createDate);
        expect(order.createDate, '19-Mar');
        expect(order.total, data['total']);
        expect(order.shippingTotal, data['shippingTotal']);
        expect(order.orderStatus, data['orderStatus']);
        expect(order.isVerified, true);
        expect(order.paymentMethod, PaymentMethod.cash);
        expect(order.cash, data['cash']);
        expect(order.mbok, data['mbok']);
      });
    });
  });
}

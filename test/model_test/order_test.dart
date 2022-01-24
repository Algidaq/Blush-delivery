import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/app_mocks.dart';
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
        expect(order.receipt.id, 'N/A');
        expect(order.receipt.src, 'N/A');
      });

      test('When constructed with billing data,', () async {
        //Arrange
        var billJson = {
          "id": "64fc621d-80e7-4618-b244-60e76a7cd06a",
          "firstName": "وصال",
          "lastName": "صولا",
          "address1": "N/A",
          "address2": "N/A",
          "city": "معموره مربع ٧١..شارع رقم ٧",
          "state": "Khartoum",
          "primaryPhone": "0923884790",
          "secondaryPhone": "0929843168"
        };
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
          "isVerified": true,
          "billing": billJson
        };
        //Act
        var order = Order.fromJson(data);
        var billing = order.billing;
        //Assert
        expect(billing.firstName, billJson['firstName']);
        expect(billing.lastName, billJson['lastName']);
        expect(billing.id, billJson['id']);
        expect(billing.city, billJson['city']);
        expect(billing.state, billJson['state']);
        expect(billing.phone, billJson['primaryPhone']);
        expect(billing.phone2, billJson['secondaryPhone']);
      });

      test('When constructed with LineItems thats it not empty', () async {
        //Arrange
        var pjson = {
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
        };
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
          "isVerified": true,
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
          'lineItems': [pjson]
        };
        //Act
        var order = Order.fromJson(data);
        var product = order.products.first;
        //Assert
        expect(product.id, pjson['id']);
        expect(product.name, pjson['name']);
        expect(product.price, pjson['productPrice']);
        expect(product.productId, pjson['productId']);
        expect(product.quantity, pjson['quantity']);
        expect(product.total, pjson['total']);
        expect(product.varationId, pjson['varationId']);
      });

      test('When constructed with notes thats is not empty', () async {
        //Arrange
        var notejson = {
          "note": "First not on to this id",
          "id": "0fc50912-e5b8-493b-af07-6fa474bee6a3",
          "createDate": "2022-01-23T11:05:32.999Z"
        };

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
          "isVerified": true,
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
          'lineItems': [
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
            }
          ],
          'notes': [notejson]
        };
        //Act
        var order = Order.fromJson(data);
        var note = order.notes.first;
        //Assert
        expect(note.id, notejson['id']);
        expect(note.note, notejson['note']);
      });

      test('When Constructed with receipt', () async {
        //Arrange
        //Act
        var order = Order.fromJson(AppMocks.kOrderMock);
        var receipt = order.receipt;
        Map<String, dynamic> rjson =
            AppMocks.kOrderMock['receipt'] as Map<String, dynamic>;
        //Assert
        expect(receipt.id, rjson['id']);
        expect(receipt.src, rjson['src']);
      });
    });
  });
}

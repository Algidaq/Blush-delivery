import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/extensions/payment_method_ext.dart';
import 'package:blush_delivery/models/order/order.dart';

class OrderUpdateModel {
  final double cash;
  final double mbok;
  final double total;
  final PaymentMethod paymentMethod;
  final double shippingTotal;
  final String id;
  const OrderUpdateModel(
      {required this.id,
      required this.cash,
      required this.mbok,
      required this.total,
      required this.paymentMethod,
      required this.shippingTotal});

  bool get canUpdate {
    switch (paymentMethod) {
      case PaymentMethod.cash:
        return cash == (total - shippingTotal);
      case PaymentMethod.mbok:
        return mbok == total;
      case PaymentMethod.cashAndMobk:
        return (cash + mbok) == total;
      case PaymentMethod.unpaid:
        return false;
    }
  }

  Map<String, dynamic> toJson({Map<String, dynamic>? extendedData}) {
    return {
      'cash': cash,
      'mbok': mbok,
      'paymentMethod': paymentMethod.code,
      'orderStatus': 'completed',
      'receipt': extendedData
    };
  }
}

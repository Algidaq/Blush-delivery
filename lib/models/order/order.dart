import 'package:blush_delivery/enums/payment_method.dart';

import 'package:blush_delivery/utils/app_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:blush_delivery/utils/utils.dart';
part 'billing.dart';
part 'product.dart';
part 'note.dart';
part 'receipt.dart';

class Order extends Equatable {
  late final String? _id;
  late final num? _orderId;
  late final String? _date;
  late final String? _createDate;
  late final int? _customerId;
  late final num? _total;
  late final num? _shippingTotal;
  late final String? _orderStatus;
  late final num? _cash;
  late final num? _mbok;
  late final int? _paymentMethod;
  late final bool? _isVerified;
  late final Billing billing;
  final List<Product> products = [];
  final List<Note> notes = [];
  late final Receipt receipt;
  Order.fromJson(Map<String, dynamic> json) {
    try {
      _id = json['id'];
      _orderId = json['orderId'];
      _date = json['date'];
      _createDate = json['createDate'];
      _customerId = json['customerId'];
      _total = json['total'];
      _shippingTotal = json['shippingTotal'];
      _orderStatus = json['orderStatus'];
      _cash = json['cash'];
      _mbok = json['mbok'];
      _paymentMethod = json['paymentMethod'];
      _isVerified = json['isVerified'];
      var billingJson = json['billing'] ?? <String, dynamic>{};
      billing = Billing.fromJson(billingJson);
      List<dynamic> productsJson = json['lineItems'] ?? [];
      products.addAll(
          productsJson.map((productJson) => Product.fromJson(productJson)));
      List<dynamic> notesJson = json['notes'] ?? [];
      notes.addAll(notesJson.map((noteJson) => Note.fromJson(noteJson)));
      receipt = Receipt.fromJson(json['receipt'] ?? <String, dynamic>{});
    } catch (e) {
      AppLogger.e(Order, e);
      rethrow;
    }
  }

  /// returns order id if not exists  or `N/A`
  String get id => _id ?? 'N/A';

  /// returns orderId assigned from woocommerce
  num get orderId => _orderId ?? 1;

  /// returns the orderId formated with #122
  String get formatedOrder => '#${orderFormater(orderId)}';

  ///returns date orders is assigned in by means reportDate
  String get reportDate => _date ?? 'N/A';

  /// returns woo-order createDate formated as DayDay-MMM
  String get createDate => DateFormat('dd-MMM')
      .format(DateTime.parse(_createDate ?? DateTime.now().toString()));

  /// returns customer id or -1
  int get customerId => _customerId ?? -1;

  /// returns order total
  num get total => _total ?? 0.0;

  /// returns a formated value of order total `#,###`
  String get formatedTotal => formatCurrency(total.toDouble());

  /// returns  shippingTotal or 0.0
  num get shippingTotal => _shippingTotal ?? 0.0;

  /// returns formated shipping total value
  String get formatedShippingTotal => formatCurrency(shippingTotal.toDouble());

  /// returns payed cash or 0.0
  num get cash => _cash ?? 0.0;

  ///returns get formated Cash value
  String get formatedCash => formatCurrency(cash.toDouble());

  /// returns mbok or 0.0
  num get mbok => _mbok ?? 0.0;

  /// returns formated mbok value
  String get formatedMbok => formatCurrency(mbok.toDouble());

  String get orderStatus => _orderStatus ?? 'processing';

  // int get _paymentMethod => _paymentMethod ?? -1;
  PaymentMethod get paymentMethod {
    switch (_paymentMethod) {
      case 0:
        return PaymentMethod.cash;
      case 1:
        return PaymentMethod.mbok;
      case 2:
        return PaymentMethod.cashAndMobk;
      default:
        return PaymentMethod.unpaid;
    }
  }

  /// is the order verified by the accounting
  bool get isVerified => _isVerified ?? false;

  String orderFormater(num number) {
    return NumberFormat('#,###').format(number);
  }

  bool get isCompleted => orderStatus == 'completed';

  @override
  List<Object?> get props => [id];
}

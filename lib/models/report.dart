import 'package:blush_delivery/utils/app_logger.dart';
import 'package:equatable/equatable.dart';

class Report extends Equatable {
  late final String? _date;
  late final String? _totalOrders;
  late final num? _totalCash;
  late final num? _totalMbok;
  late final num? _total;
  late final String? _completedOrders;
  late final String? _incompletedOrders;
  late final bool? _isVerified;
  late final num? _shippingTotal;

  Report.fromJson(Map<String, dynamic> json) {
    try {
      _date = json['date'];
      _totalOrders = json['totalOrdders'];
      _totalCash = json['totalCash'];
      _totalMbok = json['totalMbok'];
      _total = json['total'];
      _completedOrders = json['completedOrders'];
      _incompletedOrders = json['incompletedOrders'];
      _isVerified = json['isVerified'];
      _shippingTotal = json['shippingTotal'];
    } catch (e) {
      AppLogger.e(e.toString(), e);
      rethrow;
    }
  }

  String get date => _date ?? 'N/A';
  String get totalOrders => _totalOrders ?? '0';
  num get totalCash => _totalCash ?? -1;
  num get totalMbok => _totalMbok ?? -1;
  num get total => _total ?? -1;
  num get shippingTotal => _shippingTotal ?? -1;
  String get completedOrders => _completedOrders ?? '0';
  String get incompleteOrders => _incompletedOrders ?? '0';
  bool get isVerified => _isVerified ?? false;

  @override
  List<Object?> get props => [date];
}

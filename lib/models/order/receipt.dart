part of 'order.dart';

class Receipt extends Equatable {
  late final String? _id;
  late final String? _src;
  Receipt.fromJson(Map<String, dynamic> json) {
    try {
      _id = json['id'];
      _src = json['src'];
    } catch (e) {
      AppLogger.e(Receipt, e);
      rethrow;
    }
  }

  String get id => _id ?? 'N/A';
  String get src => _src == null ? 'N/A' : kAppUrl + _src!;
  @override
  List<Object?> get props => [id, src];

  Map<String, dynamic> toJson() {
    return {'id': id, 'src': _src};
  }

  @override
  String toString() {
    return const JsonEncoder().convert(toJson());
  }
}

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
  String get src => _src ?? 'N/A';
  @override
  List<Object?> get props => [id, src];
}

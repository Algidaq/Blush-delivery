part of 'order.dart';

class Product extends Equatable {
  late final String? _id;
  late final String? _name;
  late final int? _productId;
  late final int? _varationId;
  late final int? _quantity;
  late final num? _total;
  late final num? _productPrice;
  late final String? _productImage;

  Product.fromJson(Map<String, dynamic> json) {
    try {
      _id = json['id'];
      _name = json['name'];
      _productId = json['productId'];
      _varationId = json['varationId'];
      _quantity = json['quantity'];
      _total = json['total'];
      _productPrice = json['productPrice'];
      _productImage = json['productImage'];
    } catch (e) {
      AppLogger.e(Product, e);
      rethrow;
    }
  }

  String get id => _id ?? 'N/A';
  String get name => _name ?? 'N/A';
  int get productId => _productId ?? -1;
  int get varationId => _varationId ?? -1;
  int get quantity => _quantity ?? -1;
  double get total => _total?.toDouble() ?? 0.0;
  double get price => _productPrice?.toDouble() ?? 0.0;
  String get foramtedPrice => formatCurrency(price);
  String get image => _productImage ?? kImagePlaceHolder;

  @override
  List<Object?> get props => [id, productId];
}

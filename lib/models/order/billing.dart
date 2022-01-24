part of 'order.dart';

class Billing extends Equatable {
  late final String? _id;
  late final String? _firstName;
  late final String? _lastName;
  late final String? _address1;
  late final String? _address2;
  late final String? _city;
  late final String? _state;
  late final String? _primaryPhone;
  late final String? _secondaryPhone;

  Billing.fromJson(Map<String, dynamic> json) {
    try {
      _id = json['id'];
      _firstName = json['firstName'];
      _lastName = json['lastName'];
      _address1 = json['address1'];
      _address2 = json['address2'];
      _city = json['city'];
      _state = json['state'];
      _primaryPhone = json['primaryPhone'];
      _secondaryPhone = json['secondaryPhone'];
    } catch (e) {
      AppLogger.e(Billing, e);
      rethrow;
    }
  }

  String get id => _id ?? 'N/A';
  String get firstName => _firstName ?? 'N/A';
  String get lastName => _lastName ?? 'N/A';
  String get fullName => firstName + ' ' + lastName;
  String get address1 => _address1 ?? 'N/A';
  String get address2 => _address2 ?? 'N/A';
  String get city => _city ?? 'N/A';
  String get state => _state ?? 'N/A';
  String get phone => _primaryPhone ?? 'N/A';
  String get phone2 => _secondaryPhone ?? 'N/A';

  @override
  List<Object?> get props => [id];
}

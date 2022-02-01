import 'package:blush_delivery/utils/utils.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  late final String? _id;
  late final String? _firstName;
  late final String? _lastName;
  late final String? _phone;
  late final String? _role;
  late final String? _profileImage;

  User.fromJson(Map<String, dynamic> json) {
    try {
      _id = json['id'];
      _firstName = json['firstName'];
      _lastName = json['lastName'];
      _phone = json['phone'];
      _role = json['role'];
      _profileImage = json['profileImage'];
    } catch (e) {
      rethrow;
    }
  }

  ///returns id of the user if exists or N/A
  String get id => _id ?? 'N/A';

  ///returns user ``firstName`` or N/A
  String get firstName => _firstName ?? 'N/A';

  ///returns user ``lastName`` or N/A
  String get lastName => _lastName ?? 'N/A';
  String get fullName => firstName + ' ' + lastName;

  /// returns user ``phoneNumber`` or 'N/A'
  String get phone => _phone ?? 'N/A';

  /// returns user role or 'N/A'
  String get role => _role ?? 'N/A';

  /// returns {``true``} if user role is driver
  /// otherise returns ``false``
  bool get isDriver => role == 'driver';

  String get profileImage => _profileImage ?? kImagePlaceHolder;

  @override
  List<Object?> get props => [id];
}

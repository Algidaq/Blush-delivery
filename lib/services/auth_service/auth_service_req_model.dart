import 'package:blush_delivery/services/base_request_model.dart';

class AuthServiceReqModel implements BaseRequestModel {
  final String phone;
  final String password;
  AuthServiceReqModel({required this.phone, required this.password});
  @override
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phone,
      'password': password,
    };
  }
}

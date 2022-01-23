import 'package:blush_delivery/services/base_request_model.dart';

class DriverReportReqModel implements BaseRequestModel {
  final int page;
  final int limit;
  DriverReportReqModel({this.page = 1, this.limit = 10});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return 'page: $page \n  limit: $limit';
  }
}

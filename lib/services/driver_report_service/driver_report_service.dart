import 'package:blush_delivery/interfaces/i_driver_report_service.dart';
import 'package:blush_delivery/services/base_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';

class DriverReportService extends BaseService implements IDriverReportService {
  @override
  String get path => '/driver/reports';

  @override
  Future<DriverReportResModel> getDriverReports(
      {DriverReportReqModel? queryParams}) async {
    try {
      var res = await get(queryParams: queryParams?.toJson());
      return DriverReportResModel.fromJson(res.data, res.headers);
    } catch (e) {
      AppLogger.e(e.toString(), e);
      rethrow;
    }
  }
}

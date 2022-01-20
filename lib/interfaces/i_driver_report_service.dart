import 'package:blush_delivery/services/driver_report_service/driver_report_resmodel.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_reqmodel.dart';

abstract class IDriverReportService {
  Future<DriverReportResModel> getDriverReports(
      {DriverReportReqModel? queryParams});
}

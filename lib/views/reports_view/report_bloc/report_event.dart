part of 'report_bloc.dart';

abstract class ReportEvent {}

/// When reach bottom of the List to lod more Reports
class LoadReports extends ReportEvent {}

/// When Indicator is pulled to referesh content of the tree
class ReloadReports extends ReportEvent {}

class UpdateReport extends ReportEvent {
  final Report newReport;
  final Report oldReport;
  UpdateReport({required this.newReport, required this.oldReport});
}

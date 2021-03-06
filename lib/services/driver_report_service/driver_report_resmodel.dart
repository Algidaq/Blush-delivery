import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class DriverReportResModel extends Equatable {
  final List<Report> reports = [];
  late final String? _pages;
  late final String? _count;
  DriverReportResModel({int pages = 1, int count = 10})
      : _count = count.toString(),
        _pages = pages.toString();
  DriverReportResModel.fromJson(List<dynamic> json, Headers headers) {
    try {
      if (json.isNotEmpty) {
        for (var report in json) {
          reports.add(Report.fromJson(report));
        }
        _pages = headers.value('total-pages');
        _count = headers.value('count');
      }
    } catch (e) {
      rethrow;
    }
  }

  DriverReportResModel.fromRestoreJson(Map<String, dynamic> json) {
    try {
      var reportsJson = json['reports'] ?? [];
      if (reportsJson.isNotEmpty) {
        for (var report in reportsJson) {
          reports.add(Report.fromJson(report));
        }
      }
      _pages = json['totalPages'].toString();
      _count = json['count'].toString();
    } catch (e) {
      AppLogger.e(e);
      rethrow;
    }
  }

  int get totalPages => int.tryParse(_pages ?? '1') ?? 1;

  int get count => int.tryParse(_count ?? '1') ?? 10;
  DriverReportResModel copyWith(
      {List<Report> reports = const [], int? count, int? pages}) {
    var resmodel = DriverReportResModel(
      pages: pages ?? totalPages,
      count: count ?? this.count,
    );
    resmodel.reports.addAll(reports);
    return resmodel;
  }

  @override
  List<Object?> get props => [reports, totalPages, count];

  Map<String, dynamic> toJson() {
    return {'reports': reports, 'totalPages': totalPages, 'count': count};
  }
}

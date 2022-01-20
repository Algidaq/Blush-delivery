import 'package:blush_delivery/models/report.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class DriverReportResModel extends Equatable {
  final List<Report> reports = [];
  late final String? _pages;
  late final String? _count;
  DriverReportResModel();
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

  int get totalPages => int.tryParse(_pages ?? '1') ?? 1;
  int get count => int.tryParse(_count ?? '1') ?? 10;

  @override
  List<Object?> get props => [reports];
}

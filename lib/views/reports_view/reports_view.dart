import 'dart:convert';

import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/app_mocks.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/reports_view/report_bloc/report_bloc.dart';
import 'package:blush_delivery/views/reports_view/widgets/reports_list_loading.dart';
import 'package:blush_delivery/widgets/report_list_tile.dart';
import 'package:blush_delivery/widgets/sliver_center.dart';
import 'package:blush_delivery/widgets/text_with_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  _ReportsViewState createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> with RestorationMixin {
  late final ReportBloc reportBloc;
  late final ScrollController _controller;
  final RestorableReportState _restorableReportState = RestorableReportState();
  @override
  void initState() {
    reportBloc = context.read();
    _controller = ScrollController();
    _controller.addListener(handleScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppText.title(S.of(context).reports, color: Colors.white),
          actions: [kwSettingsIcon],
        ),
        backgroundColor: kcGrayLight,
        body: RefreshIndicator(
          onRefresh: handleRefresh,
          // backgroundColor: kcAccentDark,
          displacement: 0.0,
          // edgeOffset: 10.0,
          // edgeOffset: ,
          color: kcPrimary,
          child: BlocConsumer<ReportBloc, ReportState>(
              bloc: reportBloc,
              listener: handleNavigation,
              // buildWhen: (prev,curr)=> prev.reportResModel,
              builder: (context, state) {
                switch (state.viewState) {
                  case StateEnum.idel:
                    return const ReportsListLoading();
                  case StateEnum.busy:
                    return const ReportsListLoading();
                  case StateEnum.error:
                    return SingleChildScrollView(
                      child: Center(
                        child: TextWithButton(
                          text: state.message,
                          buttonText: S.of(context).reload,
                          onTap: handleRefresh,
                        ),
                      ),
                    );
                  case StateEnum.success:
                    return ListView.separated(
                        controller: _controller,
                        padding: const EdgeInsets.only(top: 8.0),
                        itemBuilder: (ctx, index) => index >=
                                state.reportResModel!.reports.length
                            ? state.hasReachedLimit ||
                                    state.reportResModel!.reports.length < 10
                                ? const SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                  )
                                : const Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation(kcPrimary),
                                          strokeWidth: 2.0,
                                        ),
                                      ),
                                    ),
                                  )
                            : ReportListTile(
                                report: state.reportResModel!.reports[index],
                                onTap: handleReportTap,
                              ),
                        separatorBuilder: (ctx, index) => Divider(
                              color: Colors.grey[350],
                              indent: 16.0,
                              endIndent: 16.0,
                              height: 0.5,
                            ),
                        itemCount: state.reportResModel!.reports.length + 1);

                  default:
                    return const ReportsListLoading();
                }
              }),
        ));
  }

  void handleNavigation(BuildContext context, ReportState state) {
    _restorableReportState.value = state;
  }

  @override
  void dispose() {
    // reportBloc.close();
    _controller.removeListener(handleScroll);
    _controller.dispose();
    _restorableReportState.dispose();
    super.dispose();
  }

  Future<void> handleRefresh() async {
    reportBloc.add(ReloadReports());

    return;
  }

  void handleScroll() {
    AppLogger.i(
        'onScroll, $_isBottom \n hasReachedLimit ${reportBloc.state.hasReachedLimit}');
    if (_isBottom) {
      reportBloc.add(LoadReports());
    }
  }

  /// A getter thats returns true when scroll poistion reach bottom
  bool get _isBottom {
    if (!_controller.hasClients) return false;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void handleReportTap(Report report) {
    Navigator.of(context).restorablePushNamed(kOrdersRoute,
        arguments: const JsonEncoder().convert(report.toJson()));
  }

  @override
  String? get restorationId => 'reports_view';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restorableReportState, 'reportState');
    AppLogger.i('Restore ${_restorableReportState.value}');
    if (_restorableReportState.value.viewState == StateEnum.busy) {
      reportBloc.add(ReloadReports());
    } else {
      reportBloc.add(RestoreState(_restorableReportState.value));
    }
  }
}

class RestorableReportState extends RestorableValue<ReportState> {
  @override
  ReportState createDefaultValue() => const ReportState();

  @override
  void didUpdateValue(ReportState? oldValue) {
    AppLogger.i(
        'value is updated Change Report state oldState is $oldValue\n new value is $value');
    if (oldValue != null && oldValue != value) {
      notifyListeners();
      AppLogger.i('notify ReportStateListeners $value');
    }
  }

  @override
  ReportState fromPrimitives(Object? data) {
    if (data != null) {
      var map = const JsonDecoder().convert(data.toString());
      return ReportState.fromJson(map);
    }
    return const ReportState();
  }

  @override
  Object? toPrimitives() {
    var save = const JsonEncoder().convert(value.toJson());
    AppLogger.e('saving', save);
    return save;
  }
}

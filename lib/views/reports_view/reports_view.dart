import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
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

class _ReportsViewState extends State<ReportsView> {
  late final ReportBloc reportBloc;
  late final ScrollController _controller;
  @override
  void initState() {
    reportBloc = ReportBloc(reportService: DriverReportService());
    _controller = ScrollController();
    _controller.addListener(handleScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppText.title('Reports', color: Colors.white),
        ),
        backgroundColor: kcGrayDark,
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
            builder: (context, state) => CustomScrollView(
              controller: _controller,
              slivers: [
                if (state.viewState == StateEnum.busy)
                  const ReportsListLoading(),
                if (state.viewState == StateEnum.error)
                  SliverCenter(
                      padding: const EdgeInsets.all(16.0),
                      child: TextWithButton(
                        text: state.message,
                        buttonText: 'Reload',
                        onTap: handleRefresh,
                      )),
                if (state.viewState == StateEnum.success)
                  SliverPadding(
                    padding: kListViewPadding,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) => index >=
                                state.reportResModel!.reports.length
                            ? state.hasReachedLimit
                                ? const SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                  )
                                : const Center(
                                    child: SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(kcPrimary),
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ReportListTile(
                                    report:
                                        state.reportResModel!.reports[index]),
                              ),
                        childCount: state.reportResModel!.reports.length + 1,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }

  void handleNavigation(BuildContext context, state) {}

  @override
  void dispose() {
    reportBloc.close();
    _controller.removeListener(handleScroll);
    _controller.dispose();
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
}

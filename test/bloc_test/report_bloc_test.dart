import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/reports_view/report_bloc/report_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../services_mocks/driver_report_service_mock.dart';

void main() {
  group('ReportBloc Test-', () {
    group('Construction Test-', () {
      test('When should start with viewState thats is busy', () async {
        //Arrange
        var bloc = ReportBloc(reportService: DriverReportSerivceMock());
        //Act
        //Assert
        expect(bloc.state.viewState, StateEnum.busy);
        expect(bloc.state.hasReachedLimit, false);
        expect(bloc.state.reportResModel, isNull);
      });
    });

    group('Event mockService Test-', () {
      test(
          'When ReloadEvent is called in ,state should change be busy,load reports',
          () async {
        //Arrange
        var bloc = ReportBloc(reportService: DriverReportSerivceMock());
        //Act
        bloc.add(ReloadReports());
        //Assert
        await Future.delayed(Duration.zero);
        expect(bloc.state.viewState, StateEnum.busy);
        await Future.delayed(const Duration(seconds: 2));
        expect(bloc.state.viewState, StateEnum.success);
        expect(bloc.state.reportResModel, isNotNull);
        expect(bloc.state.reportResModel!.reports.length, 9);
        expect(bloc.state.hasReachedLimit, false);
        expect(bloc.state.currentPage, 1);
      });

      test('When ReloadEvent is Called and An Error is Raised', () async {
        //Arrange
        var bloc = ReportBloc(reportService: DriverServiceErrorMock());
        //Act
        bloc.add(ReloadReports());
        //assertion
        await Future.delayed(const Duration(seconds: 3));
        expect(bloc.state.viewState, StateEnum.error);
        expect(bloc.state.message.isNotEmpty, true);
      });

      test(
          'When LoadReport is Called this action will be called 3 times , asserting three states',
          () async {
        //Arrange
        //Arrange
        var bloc = ReportBloc(reportService: DriverReportSerivceMock());
        //Act
        bloc.add(ReloadReports());
        await Future.delayed(const Duration(seconds: 3));
        // await Future.delayed(Duration.zero);
        expect(bloc.state.viewState, StateEnum.success);
        expect(bloc.state.reportResModel!.reports.length, 9);
        // Acting as if the user reached end scroll
        bloc.add(LoadReports());
        await Future.delayed(const Duration(seconds: 3));
        //Assert
        await Future.delayed(Duration.zero);
        expect(bloc.state.viewState, StateEnum.success);
        expect(bloc.state.reportResModel, isNotNull);
        expect(bloc.state.reportResModel!.reports.length, 18);
        expect(bloc.state.currentPage, 2);

        bloc.add(LoadReports());
        await Future.delayed(const Duration(seconds: 3));
        //Assert
        await Future.delayed(Duration.zero);

        expect(bloc.state.hasReachedLimit, true);
      });
    });
  });
}

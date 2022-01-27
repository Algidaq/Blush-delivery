import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/services/driver_report_service/driver_report_service.dart';
import 'package:blush_delivery/services/report_orders_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/app_mocks.dart';
import 'package:blush_delivery/views/login_view/login_bloc/login_bloc.dart';
import 'package:blush_delivery/views/login_view/login_view.dart';
import 'package:blush_delivery/views/orders_view/orders_bloc/orders_bloc.dart';
import 'package:blush_delivery/views/orders_view/orders_view.dart';
import 'package:blush_delivery/views/orders_view/widgets/order_header/order_header_bloc/order_header_bloc.dart';
import 'package:blush_delivery/views/reports_view/report_bloc/report_bloc.dart';
import 'package:blush_delivery/views/reports_view/reports_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kLoginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (__) => LoginBloc(
              authService: RepositoryProvider.of<AuthService>(__),
            ),
            child: const LoginView(),
          ),
          // settings: settings,
        );
      case kReportsView:
        return MaterialPageRoute(builder: (_) => const ReportsView());
      case kOrdersRoute:
        var report = (settings.arguments as Report?) ??
            Report.fromJson(AppMocks.kReportMock);
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<OrdersBloc>(
                      create: (context) => OrdersBloc(
                        orderService: ReportOrdersService(),
                        report: report,
                      ),
                    ),
                    BlocProvider<OrderHeaderBloc>(
                      create: (__) => OrderHeaderBloc(
                        report: report,
                        reportService: DriverReportService(),
                      ),
                    ),
                  ],
                  child: OrdersView(report: report),
                ));
      case kMainRoute:
        return MaterialPageRoute(
          builder: (ctx) => Container(
            color: Colors.white,
            child: const AppText.body('UnkownRoute'),
          ),
          // settings: settings,
        );
    }
  }

  List<Route>? onGenerateInitialRoute(String initialRoute) {}
}

class AppRouterObserver with NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    AppLogger.i('Pop:${[route, previousRoute]}');
    // super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    AppLogger.i('Push:${[route, previousRoute]}');
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    AppLogger.i('Remove:${[route, previousRoute]}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    AppLogger.i('Replace:${[newRoute, oldRoute]}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

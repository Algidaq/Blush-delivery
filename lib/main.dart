import 'package:blush_delivery/app_bloc.dart';
import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/report.dart';
import 'package:blush_delivery/repo/app_pref.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/theme/app_theme.dart';
import 'package:blush_delivery/utils/app_mocks.dart';
import 'package:blush_delivery/widgets/order_list_tile.dart/order_list_tile.dart';
import 'package:blush_delivery/widgets/order_list_tile.dart/order_loading_list_tile.dart';
import 'package:blush_delivery/widgets/report_list_tile.dart';
import 'package:blush_delivery/widgets/report_loading_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var pref = await SharedPreferences.getInstance();

  runApp(MyApp(
    preferences: pref,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;
  const MyApp({Key? key, required this.preferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppPref>(
          lazy: false,
          create: (ctx) => AppPref(preferences),
        ),
        RepositoryProvider<AuthService>(create: (context) => AuthService()),
        RepositoryProvider<User>(
          create: (context) =>
              RepositoryProvider.of<AuthService>(context).user!,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (cxt) => AppBloc(
              RepositoryProvider.of<AppPref>(cxt),
            ),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(844.0, 390.0),
            builder: () => BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      supportedLocales: S.delegate.supportedLocales,
                      localizationsDelegates: const [
                        S.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],

                      theme: kLightThemeData,
                      locale: state.locale,
                      color: kcPrimary,
                      themeMode: state.themeMode,
                      // darkTheme: ThemeData(backgroundColor: Colors.black),
                      onGenerateRoute: router.onGenerateRoute,
                      initialRoute: kLoginRoute,
                      navigatorObservers: [AppRouterObserver()],
                      // onGenerateInitialRoutes: router.onGenerateInitialRoute,
                      // home: Scaffold(
                      //   appBar: AppBar(),
                      //   backgroundColor: kcGrayDark,
                      //   body: ListView(
                      //     // padding: kListViewPadding,
                      //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                      //     children: [
                      //       OrderListTile(
                      //         order: Order.fromJson(AppMocks.kOrderMock),
                      //       ),
                      //       const OrderLoadingListTile(),
                      //     ],
                      //   ),
                      // ),
                    );
                  },
                )),
      ),
    );
  }
}

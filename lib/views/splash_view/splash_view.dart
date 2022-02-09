import 'package:blush_delivery/repo/app_pref.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/services/http_service.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with RestorationMixin {
  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: AnimatedOpacity(
        opacity: 0.3,
        curve: Curves.easeInOut,
        duration: const Duration(seconds: 2),
        child: Image.asset(
          'assets/images/icon.png',
          width: double.maxFinite,
          height: 254.0,
        ),
      ),
    );
  }

  Future<void> setup() async {
    final AppPref pref = RepositoryProvider.of<AppPref>(context);

    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
    AppLogger.i('onEnd');
    var route = pref.token == null ? kLoginRoute : kReportsView;
    HttpService.instance.token = pref.token;
    AppLogger.d('route is $route');
    Navigator.restorablePushReplacementNamed(context, route);
  }

  @override
  String? get restorationId => 'splash_view';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {}
}

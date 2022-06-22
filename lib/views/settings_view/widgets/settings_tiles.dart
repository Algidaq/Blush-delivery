import 'package:blush_delivery/app_bloc.dart';
import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/routes/app_router.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/views/settings_view/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTiles extends StatelessWidget {
  final AppBloc appBloc;
  final IAuthService authService;
  const SettingsTiles(
      {Key? key, required this.appBloc, required this.authService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingsTile(
              icon: Icon(
                appBloc.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              text: appBloc.isDarkMode
                  ? S.of(context).switchToLight
                  : S.of(context).switchToDark,
              trailing: Switch(
                  value: appBloc.isDarkMode, onChanged: handleThemeChange),
              onTap: () => handleThemeChange(!appBloc.isDarkMode),
            ),
            verticalSpaceTiny,
            SettingsTile(
              text: appBloc.isArabic
                  ? S.of(context).switchToEng
                  : S.of(context).switchToArb,
              icon: const Icon(Icons.language),
              trailing: Switch(
                  value: appBloc.isArabic, onChanged: handleLangugeChange),
              onTap: () => handleLangugeChange(!appBloc.isArabic),
            ),
            verticalSpaceTiny,
            SettingsTile(
              text: S.of(context).logout,
              icon: const Icon(
                Icons.power_settings_new_rounded,
              ),
              onTap: () => handleLogout(context),
            )
          ],
        ),
      ),
    );
    ;
  }

  void handleThemeChange(bool value) {
    appBloc.add(AppThemeChange(value ? ThemeMode.dark : ThemeMode.light));
  }

  void handleLangugeChange(bool value) {
    appBloc.add(AppLangChange(value ? const Locale('ar') : const Locale('en')));
  }

  Future<void> handleLogout(BuildContext context) async {
    await authService.logout();
    Navigator.restorablePushNamedAndRemoveUntil(
        context, kLoginRoute, (route) => route.settings.name == kLoginRoute);
  }
}

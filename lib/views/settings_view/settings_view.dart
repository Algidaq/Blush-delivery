import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/views/settings_view/widgets/settings_sliver_app_bar.dart';
import 'package:blush_delivery/views/settings_view/widgets/settings_tiles.dart';
import 'package:blush_delivery/views/settings_view/widgets/settings_user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late final IAuthService authService;
  bool isDrakMode = false;
  @override
  void initState() {
    authService = RepositoryProvider.of<AuthService>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16.0);
    return Scaffold(
      backgroundColor: kcGrayDark,
      body: CustomScrollView(
        slivers: [
          SettingsSliverAppBar(onBack: handleBackNavigation),
          SliverToBoxAdapter(
            child: verticalSpaceRegular,
          ),
          SettingsUserTile(authService: authService),
          SliverToBoxAdapter(
            child: verticalSpaceRegular,
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: AppText.subtitle2('General Settings'),
            ),
          ),
          SliverToBoxAdapter(
            child: verticalSpaceSmall,
          ),
          SettingsTiles(
            appBloc: context.read(),
            authService: authService,
          )
        ],
      ),
    );
  }

  void handleBackNavigation() {
    Navigator.of(context).pop();
  }
}

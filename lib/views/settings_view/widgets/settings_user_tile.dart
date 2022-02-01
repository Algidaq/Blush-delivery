import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SettingsUserTile extends StatelessWidget {
  final IAuthService authService;
  const SettingsUserTile({Key? key, required this.authService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox.square(
                dimension: 40.0,
                child: CachedNetworkImage(
                  imageUrl: authService.user?.profileImage ?? kImagePlaceHolder,
                ),
              ),
            ),
            horizontalSpaceRegular,
            AppText.body(authService.user?.fullName ?? 'N/A')
          ],
        ),
      ),
    );
  }
}

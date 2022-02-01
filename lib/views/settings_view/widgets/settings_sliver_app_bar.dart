import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:flutter/material.dart';

class SettingsSliverAppBar extends StatelessWidget {
  final VoidCallback? onBack;
  const SettingsSliverAppBar({Key? key, required this.onBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 104.0,
      pinned: true,
      leading: const SizedBox(),
      flexibleSpace: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: AppText.title(
                S.of(context).settings,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

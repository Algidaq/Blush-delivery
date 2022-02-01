import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
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
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: AppText.title(
                'Settings',
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

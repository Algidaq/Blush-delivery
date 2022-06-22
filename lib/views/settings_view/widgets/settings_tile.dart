import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final Icon? icon;
  final Widget? trailing;
  final String text;
  final VoidCallback? onTap;
  const SettingsTile(
      {Key? key, required this.text, this.icon, this.onTap, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 48.0,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (icon != null) SizedBox(width: 40.0, child: icon!),
                    if (icon != null) horizontalSpaceRegular,
                    AppText.body2(text),
                  ],
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
      kListTileDivider,
    ]);
  }
}

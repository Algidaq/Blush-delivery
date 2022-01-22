import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_button.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

class TextWithButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final String buttonText;
  final Color? textColor;
  const TextWithButton(
      {Key? key,
      required this.text,
      required this.buttonText,
      this.onTap,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: AppText.subtitle(
            text,
            color: textColor,
          ),
        ),
        horizontalSpaceTiny,
        Expanded(
          flex: 2,
          child: AppButton.text(
            buttonText,
            onTap: onTap,
            // width: 96.0,
          ),
        )
      ],
    );
  }
}

import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool _outlined;
  final String text;
  final bool busy;
  final bool disabled;
  final VoidCallback? onTap;
  final double width;
  final Widget? leading;
  const AppButton(this.text,
      {Key? key,
      this.onTap,
      this.busy = false,
      this.disabled = false,
      this.width = double.maxFinite,
      this.leading})
      : _outlined = false,
        super(key: key);
  const AppButton.outlined(this.text,
      {Key? key,
      this.onTap,
      this.busy = false,
      this.disabled = false,
      this.width = double.maxFinite,
      this.leading})
      : _outlined = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48.0,
      child: Material(
        color: backgroundColor,
        animationDuration: const Duration(milliseconds: 500),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadiusMid,
          side: _outlined
              ? const BorderSide(width: 1.0, color: kcPrimary)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: disabled || busy ? null : onTap,
          borderRadius: kBorderRadiusMid,
          splashFactory: InkRipple.splashFactory,
          splashColor: kcPrimarySwatch[50]?.withOpacity(0.5),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null) leading!,
                if (busy)
                  const SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(kcAccentDark),
                      strokeWidth: 4.0,
                    ),
                  ),
                if (!busy)
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: AppText.button(
                        text.toUpperCase(),
                        color: disabled
                            ? Colors.grey[600]
                            : _outlined
                                ? kcPrimary
                                : Colors.white,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get backgroundColor {
    if (disabled || busy) {
      return Colors.grey[200]!;
    } else {
      return _outlined ? Colors.transparent : kcPrimary;
    }
  }
}

import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:flutter/material.dart';

class ReportProgress extends StatelessWidget {
  final num progress;
  final double width;
  final double height;
  const ReportProgress(
      {Key? key, required this.progress, this.width = 48.0, this.height = 48.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: AppText.body2(
                progress.toInt().toString() + '%',
              ),
            ),
            SizedBox(
              height: height,
              width: width,
              child: TweenAnimationBuilder<double>(
                tween:
                    Tween<double>(begin: 0.0, end: progress.toDouble() / 100),
                duration: const Duration(seconds: 3),
                builder: (_, value, __) => CircularProgressIndicator(
                  value: value,
                  color: kcAccentLight,
                  backgroundColor: kcPrimary,
                  strokeWidth: 6.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

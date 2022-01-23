part of 'app_shared.dart';

final Widget horizontalSpaceTiny = SizedBox(width: 4.0.w);
final Widget horizontalSpaceSmall = SizedBox(width: 8.0.w);
final Widget horizontalSpaceRegular = SizedBox(width: 16.0.w);
final Widget horizontalSpaceMedium = SizedBox(width: 24.0.w);
final Widget horizontalSpaceLarge = SizedBox(width: 48.0.w);
final Widget verticalSpaceTiny = SizedBox(height: 4.0.h);

final Widget verticalSpaceSmall = SizedBox(height: 8.0.h);

final Widget verticalSpaceRegular = SizedBox(height: 16.0.h);

final Widget verticalSpaceMedium = SizedBox(height: 24.0.h);

final Widget verticalSpaceSemiLarge = SizedBox(height: 32.0.h);

final Widget verticalSpaceLarge = SizedBox(height: 48.0.h);

final Widget verticalSpaceXLarge = SizedBox(height: 64.0.h);
final EdgeInsets kListViewPadding =
    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h);

const BorderRadius kBorderRadiusMid = BorderRadius.all(Radius.circular(12.0));
const BorderRadius kBorderRadiusSemiLarge =
    BorderRadius.all(Radius.circular(16.0));
const BorderRadius kBorderRadiusLarge = BorderRadius.all(Radius.circular(24.0));

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

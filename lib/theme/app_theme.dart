import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kTextTheme = TextTheme(
  headline1: kHeadlineStyle,
  headline2: kHeadlineStyle,
  headline3: kHeadlineStyle,
  headline4: kHeadlineStyle,
  headline5: kHeadlineStyle,
  headline6: kTitleStyle,
  subtitle1: kSubtitleStyle,
  subtitle2: kSubtitle2Style,
  bodyText1: kBodyStyle,
  bodyText2: kBody2Style,
  button: kButtonStyle,
  caption: kCaptionStyle,
  overline: kOverlineStyle,
);

final kLightThemeData = ThemeData(
    textTheme: kTextTheme,
    primarySwatch: kcPrimarySwatch,
    primaryColor: kcPrimary,
    primaryColorDark: kcPrimary,
    primaryColorLight: kcPrimaryLight,
    // pageTransitionsTheme: const PageTransitionsTheme(
    //     builders: <TargetPlatform, PageTransitionsBuilder>{
    //       TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //       TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    //     }),
    colorScheme: ColorScheme.fromSwatch(
      errorColor: Colors.red,
      backgroundColor: kcGrayLight,
      accentColor: kcAccentLight,
      primaryColorDark: kcPrimary,
      primarySwatch: kcPrimarySwatch,
      cardColor: Colors.white,
    ),
    errorColor: Colors.red,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: kcPrimary,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0))),
      centerTitle: true,
    ));

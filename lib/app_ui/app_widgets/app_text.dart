import 'package:blush_delivery/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String data;
  final Color? color;
  final TextAlign? align;
  final _TextStyle _style;
  final TextDecoration? decoration;
  const AppText.headline(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.headline,
        super(key: key);
  const AppText.title(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.title,
        super(key: key);
  const AppText.subtitle(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.subtitle,
        super(key: key);
  const AppText.subtitle2(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.subtitle2,
        super(key: key);
  const AppText.body(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.body,
        super(key: key);
  const AppText.button(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.button,
        super(key: key);
  const AppText.caption(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.caption,
        super(key: key);
  const AppText.overline(this.data,
      {Key? key, this.color, this.align, this.decoration})
      : _style = _TextStyle.overline,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle(context);
    return Text(
      data,
      style: textStyle,
      textAlign: align,
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    switch (_style) {
      case _TextStyle.headline:
        return context.textTheme.headline5?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.title:
        return context.textTheme.headline6?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.subtitle:
        return context.textTheme.subtitle1?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.subtitle2:
        return context.textTheme.subtitle2?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.body:
        return context.textTheme.bodyText1?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.button:
        return context.textTheme.button?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.caption:
        return context.textTheme.caption?.copyWith(
          color: color,
          decoration: decoration,
        );
      case _TextStyle.overline:
        return context.textTheme.overline
            ?.copyWith(color: color, decoration: decoration);
    }
  }
}

enum _TextStyle {
  headline,
  title,
  subtitle,
  subtitle2,
  body,
  button,
  caption,
  overline
}

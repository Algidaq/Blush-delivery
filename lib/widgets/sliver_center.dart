import 'package:flutter/material.dart';

class SliverCenter extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const SliverCenter({Key? key, required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          padding: padding,
          height: MediaQuery.of(context).size.height -
              64.0 -
              MediaQuery.of(context).viewInsets.top,
          alignment: Alignment.center,
          child: child),
    );
  }
}

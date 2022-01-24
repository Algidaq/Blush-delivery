import 'package:blush_delivery/utils/state_enum.dart';
import 'package:flutter/material.dart';

class StateSwitch extends StatelessWidget {
  final StateEnum viewState;
  final Widget? busy;
  final Widget? success;
  final Widget? error;
  final Widget? idel;
  const StateSwitch(
      {Key? key,
      required this.viewState,
      this.busy,
      this.success,
      this.error,
      this.idel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (viewState) {
      case StateEnum.idel:
        return idel ?? Container();
      case StateEnum.busy:
        return busy ?? Container();
      case StateEnum.error:
        return error ?? Container();
      case StateEnum.success:
        return success ?? Container();
    }
  }
}

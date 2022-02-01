import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blush_delivery/extensions/exception_ext.dart';
import 'package:blush_delivery/interfaces/i_edit_order_service.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_view/order_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'order_view_state.dart';
part 'order_view_event.dart';

class OrderViewBloc extends Bloc<OrderViewEvent, OrderViewState>
    with ExceptionMessageExt {
  final IEditOrderService service;
  late final FormGroup formGroup;
  OrderViewBloc({required Order order, required this.service})
      : super(OrderViewState(order: order, viewState: StateEnum.idel)) {
    on<AddNote>(handleAddNote);
    on<RestoreOrderState>(handleRestoration);
    formGroup = FormGroup(
      {
        'note': FormControl<String>(
            value: '',
            validators: [Validators.required, Validators.minLength(10)])
      },
    );
  }

  FutureOr<void> handleAddNote(
      AddNote event, Emitter<OrderViewState> emit) async {
    try {
      emit(state.copyWith(viewState: StateEnum.busy));
      var order =
          await service.addOrderNotes(id: state.order.id, data: notesData);
      emit(state.copyWith(viewState: StateEnum.success, order: order));
      reset();
    } catch (e) {
      var message = getErrorMessage(e);
      emit(state.copyWith(viewState: StateEnum.error, message: message));
    }
  }

  String get note => formGroup.control('note').value.toString();
  void reset() => formGroup.control('note').value = '';
  List<Map<String, dynamic>> get notesData {
    var data = state.order.notes.map((e) => e.toJson()).toList()
      ..add({'note': note});
    return data;
  }

  void handleRestoration(
      RestoreOrderState event, Emitter<OrderViewState> emit) {
    emit(event.orderViewState);
  }
}

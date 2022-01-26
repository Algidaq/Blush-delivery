import 'package:bloc/bloc.dart';
import 'package:blush_delivery/enums/payment_method.dart';
import 'package:blush_delivery/interfaces/i_edit_order_service.dart';
import 'package:blush_delivery/models/order/order.dart';
import 'package:blush_delivery/models/order_update_model.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OrderEditBottomSheetBloc extends Cubit<StateEnum> {
  late final FormGroup formGroup;
  final Order order;
  final _numberValidator = Validators.pattern(RegExp(r'[0-9]'));
  final IEditOrderService service;
  OrderEditBottomSheetBloc(this.order, this.service) : super(StateEnum.idel) {
    formGroup = FormGroup({
      'paymentMethod': FormControl<PaymentMethod>(value: PaymentMethod.unpaid),
      'cash': FormControl<double>(value: 0.0),
      'mbok': FormControl<double>(value: 0.0),
      'receipt': FormControl<String>(value: '')
    });
    paymentMethodCont.valueChanges.listen(handlePaymentMethodChange);
  }
  AbstractControl<PaymentMethod> get paymentMethodCont =>
      formGroup.control('paymentMethod') as AbstractControl<PaymentMethod>;
  AbstractControl<double> get cashCont =>
      formGroup.control('cash') as AbstractControl<double>;
  AbstractControl<double> get mbokCont =>
      formGroup.control('mbok') as AbstractControl<double>;
  AbstractControl<String> get receiptCont =>
      formGroup.control('receipt') as AbstractControl<String>;
  OrderUpdateModel get updateModel => OrderUpdateModel(
        id: order.id,
        cash: cashCont.value ?? 0.0,
        mbok: mbokCont.value ?? 0.0,
        total: order.total.toDouble(),
        paymentMethod: paymentMethodCont.value ?? PaymentMethod.unpaid,
        shippingTotal: order.shippingTotal.toDouble(),
      );
  void handlePaymentMethodChange(PaymentMethod? paymentMethod) {
    if (paymentMethod != null) {
      switch (paymentMethod) {
        case PaymentMethod.cash:
          handleCashSelected();
          break;
        case PaymentMethod.mbok:
          handleMbokSelected();
          break;
        case PaymentMethod.cashAndMobk:
          handleCashAndMobkSelected();
          break;
        case PaymentMethod.unpaid:
          resetForm();
          break;
      }
    }
  }

  bool get showReceipt {
    if (paymentMethodCont.value == null) {
      return false;
    } else if (paymentMethodCont.value == PaymentMethod.unpaid ||
        paymentMethodCont.value == PaymentMethod.cash) {
      return false;
    }
    return true;
  }

  bool get showCash {
    return paymentMethodCont.value != null &&
        paymentMethodCont.value == PaymentMethod.cashAndMobk;
  }

  void handleCashSelected() {
    cashCont.value = (order.total - order.shippingTotal).toDouble();
    mbokCont.value = 0.0;
  }

  void handleMbokSelected() {
    /// reset cash value 0.0
    cashCont.value = 0.0;

    /// set the mobk value to the order total
    mbokCont.value = order.total.toDouble();

    /// reset the receipt value to be empty
    receiptCont.value = null;

    /// set validators of the receipt contorller to be required
    receiptCont.setValidators([Validators.required],
        updateParent: true, autoValidate: true);
  }

  void handleCashAndMobkSelected() {
    /// set the value of the cash to be null
    cashCont.value = null;

    /// set the value of the mbok to be null
    mbokCont.value = null;
    //set the cash controller to be required and has to be number
    cashCont.setValidators([
      Validators.required,
      _numberValidator,
      Validators.min(order.shippingTotal)
    ], autoValidate: true);

    /// set the mbok value to validators
    mbokCont.setValidators(
      [
        Validators.required,
        _numberValidator,
        Validators.min(order.shippingTotal)
      ],
      updateParent: true,
      autoValidate: true,
    );

    /// set reset the controller and set it to null
    receiptCont.value = null;
    receiptCont.setValidators([Validators.required],
        updateParent: true, autoValidate: true);
  }

  /// reset the form validators to be none
  void resetForm() {
    /// reset the form validators
    cashCont.setValidators([], autoValidate: true);
    mbokCont.setValidators([], updateParent: true, autoValidate: true);
    receiptCont.setValidators([], updateParent: true, autoValidate: true);
  }

  ///reset the values
  void restValues() {
    cashCont.value = 0.0;
    mbokCont.value = 0.0;
    receiptCont.value = '';
  }

  Future<void> handleOrderUpdate() async {
    try {
      if (updateModel.canUpdate) {
      } else {
        formGroup
            .setErrors({'invalidCashAndMbok': 'Invalid Cash and Mbok values'});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> handleImagePicker() async {
    try {
      var showGallery =
          await service.permissionService.getStroagePermissionStatus();
      if (showGallery) {
        var file = await service.imagePickerService.getImageFromGallery();
        if (file != null) {
          receiptCont.value = file.name;
        }
      }
    } catch (e) {
      AppLogger.e(e.toString(), e);
    }
  }

  @override
  Future<void> close() {
    paymentMethodCont.dispose();
    cashCont.dispose();
    mbokCont.dispose();
    receiptCont.dispose();
    return super.close();
  }
}

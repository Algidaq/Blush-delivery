import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_button.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_input.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_edit_bottom_sheet/order_edit_bottom_sheet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OrderEditForm extends StatelessWidget {
  final OrderEditBottomSheetBloc bloc;
  final FormGroup form;
  final Widget? child;
  const OrderEditForm({
    Key? key,
    required this.bloc,
    required this.form,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        child ?? const SizedBox(),
        verticalSpaceTiny,
        if (bloc.showReceipt)
          AppInput(
            formControllerName: 'receipt',
            label: S.of(context).receipt,
            hint: S.of(context).selectImagePath,
            inputType: TextInputType.none,
            onTap: bloc.handleImagePicker,
            trailingIcon: IconButton(
              onPressed: bloc.handleImagePicker,
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: kcPrimary,
              ),
              splashColor: kcAccentLight,
            ),
          ),
        verticalSpaceTiny,
        if (form.hasError('invalidCashAndMbok')) ...[
          AppText.body2(
            form.errors['invalidCashAndMbok'].toString(),
            color: Colors.red,
          ),
          verticalSpaceTiny
        ],
        if (bloc.showCash)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 24.0,
                child: AppInput(
                  formControllerName: 'cash',
                  label: S.of(context).cash,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 24.0,
                child: AppInput(
                  formControllerName: 'mbok',
                  label: S.of(context).mbok,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              )
            ],
          ),
        verticalSpaceRegular,
        BlocBuilder<OrderEditBottomSheetBloc, OrderEditBottomSheetState>(
          bloc: bloc,
          builder: (context, state) {
            return AppButton(
              S.of(context).update,
              disabled: form.invalid,
              busy: state.viewState == StateEnum.busy,
              onTap: bloc.handleOrderUpdate,
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        )
      ],
    );
  }
}

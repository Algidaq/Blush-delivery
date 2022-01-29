import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_button.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_input.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/order_view/order_view_bloc/order_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OrderNote extends StatelessWidget {
  final VoidCallback? onSeeAllNotes;
  final VoidCallback? onAddNotes;
  final OrderViewBloc bloc;
  const OrderNote({
    Key? key,
    required this.bloc,
    this.onSeeAllNotes,
    this.onAddNotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: bloc.formGroup,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText.subtitle2('Notes'),
                GestureDetector(
                  onTap: onSeeAllNotes,
                  child: AppText.button(
                    'see all'.toUpperCase(),
                    color: kcPrimary,
                  ),
                )
              ],
            ),
            const Divider(),
            const AppInput(
              formControllerName: 'note',
              label: 'Notes',
              hint: 'Insert Note for this order',
              maxLines: 4,
            ),
            verticalSpaceSmall,
            ReactiveFormConsumer(builder: (context, form, child) {
              return BlocBuilder<OrderViewBloc, OrderViewState>(
                bloc: bloc,
                builder: (context, state) {
                  return AppButton(
                    'Add Note',
                    disabled: form.invalid,
                    onTap: onAddNotes,
                    busy: state.viewState == StateEnum.busy,
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}

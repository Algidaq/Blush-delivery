import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppInput extends StatelessWidget {
  final String formControllerName;
  final VoidCallback? onTap;
  final VoidCallback? onSubmit;
  final String? hint;
  final String? label;
  final Color? labelColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextDirection? textDirection;
  final bool password;
  final int? maxLength;
  final int? maxLines;
  final InputBorder _outlinedBorder;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? leadingText;
  final String? trailingText;
  final ValidationMessagesFunction? validationMessages;

  const AppInput({
    Key? key,
    required this.formControllerName,
    this.validationMessages,
    this.hint,
    this.label,
    this.labelColor,
    this.onTap,
    this.inputFormatters,
    this.password = false,
    this.onSubmit,
    this.inputType,
    this.inputAction,
    this.textDirection,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingText,
    this.trailingText,
    this.maxLength,
    this.maxLines,
  })  : _outlinedBorder =
            const OutlineInputBorder(borderRadius: kBorderRadiusMid),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppText.subtitle2(
            label ?? 'No Label',
            color: Colors.black,
          ),
        if (label != null) verticalSpaceSmall,
        ReactiveTextField(
          formControlName: formControllerName,
          autocorrect: false,
          onTap: onTap,
          cursorColor: kcAccentDark,
          cursorRadius: const Radius.circular(2.0),
          clipBehavior: Clip.antiAlias,
          inputFormatters: inputFormatters,
          obscureText: password,
          onSubmitted: onSubmit,
          keyboardType: inputType,
          textInputAction: inputAction,
          maxLength: maxLength,
          maxLines: maxLines,
          style: context.textTheme.bodyText1,
          textDirection: textDirection,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          validationMessages: validationMessages,
          decoration: InputDecoration(
            prefixIcon: leadingIcon,
            prefixText: leadingText,
            suffixIcon: trailingIcon,
            suffixText: trailingText,
            hintText: hint,
            hintMaxLines: 1,
            hintStyle:
                context.textTheme.bodyText1?.copyWith(color: Colors.grey[350]),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            filled: true,
            fillColor: Colors.white,
            border: _outlinedBorder.copyWith(
              borderSide: BorderSide(width: 1.0, color: Colors.grey[300]!),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorBorder: _outlinedBorder.copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
            enabledBorder: _outlinedBorder.copyWith(
              borderSide: BorderSide(width: 1.0, color: Colors.grey[300]!),
            ),
            focusedBorder: _outlinedBorder.copyWith(
              borderSide: const BorderSide(color: kcPrimaryMed),
            ),
            counterStyle: context.textTheme.caption,
            errorStyle: context.textTheme.caption?.copyWith(color: Colors.red),
          ),
        )
      ],
    );
  }
}

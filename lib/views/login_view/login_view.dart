import 'package:blush_delivery/app_bloc.dart';
import 'package:blush_delivery/app_ui/app_shared/app_shared.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_button.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_input.dart';
import 'package:blush_delivery/app_ui/app_widgets/app_text.dart';
import 'package:blush_delivery/generated/l10n.dart';
import 'package:blush_delivery/utils/app_logger.dart';
import 'package:blush_delivery/utils/state_enum.dart';
import 'package:blush_delivery/views/login_view/login_bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginBloc _loginBloc;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
    _loginBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: loginListener,
          listenWhen: (previous, current) => previous.state != current.state,
          child: ReactiveForm(
            formGroup: _loginBloc.formGroup,
            onWillPop: () async => !_loginBloc.isBusy,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                verticalSpaceTiny,
                Image.asset(
                  'assets/images/icon.png',
                  width: double.maxFinite,
                  height: 96.h,
                ),
                verticalSpaceRegular,
                AppText.headline(S.of(context).login),
                verticalSpaceSmall,
                AppInput(
                  formControllerName: _loginBloc.phoneContName,
                  label: S.of(context).phoneNumber,
                  hint: '902296933',
                  leadingText: context.read<AppBloc>().isArabic ? null : '+249',
                  trailingText:
                      context.read<AppBloc>().isArabic ? '249+' : null,
                  textDirection: TextDirection.ltr,
                  maxLength: 9,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                verticalSpaceTiny,
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, curr) =>
                      prev.hidePassword != curr.hidePassword,
                  builder: (context, state) {
                    return AppInput(
                      formControllerName: _loginBloc.passContName,
                      label: S.of(context).pass,
                      hint: 'Enter your password',
                      password: state.hidePassword,
                      maxLength: 56,
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      trailingIcon: GestureDetector(
                        onTap: () => _loginBloc.add(LoginTogglePassword()),
                        child: Icon(
                          state.hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
                verticalSpaceRegular,
                ReactiveFormConsumer(
                  builder: (_, form, __) => BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return AppButton(
                        'login',
                        disabled: form.invalid,
                        onTap: _loginBloc.handleLogin,
                        busy: _loginBloc.isBusy,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginListener(BuildContext context, LoginState state) {
    if (state.state == StateEnum.error) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            backgroundColor: kcAccentLight,
            duration: const Duration(seconds: 2),
            padding: const EdgeInsets.all(16.0),
            content: AppText.body(state.errorMessage ?? 'no'),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)),
            ),
          ),
        );
    }
    if (state.state == StateEnum.success) {
      AppLogger.i('Route is ${state.route}');
    }
  }
}

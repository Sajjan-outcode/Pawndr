import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/common_widgets/Loader/loader.dart';
import '../../base/common_widgets/background_view.dart';
import '../../base/common_widgets/buttons/app_button.dart';
import '../../base/common_widgets/buttons/app_button_state.dart';
import '../../base/common_widgets/buttons/decorators/primary_button_decorator.dart';
import '../../base/common_widgets/snackbar/snackbar_style.dart';
import '../../base/common_widgets/text_fields/app_textfield.dart';
import '../../base/utils/app_styles.dart';
import '../../base/utils/colors.dart';
import '../../base/utils/images.dart';
import '../../base/utils/utilities.dart';
import '../../injector/injector.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: "/login"),
        builder: (_) => const LoginScreen());
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObsecuredText = true;
  final _formKey = GlobalKey<FormState>();

  late final LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = Injector.instance<LoginBloc>();
    super.initState();

    if (kDebugMode) {
      _emailAddressController.text = "ashwin.shrestha@outcodesoftware.com";
      _passwordController.text = "Xpr3sS!23";
    }
  }

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.transparent,
          body: BlocConsumer<LoginBloc, LoginState>(
            bloc: _loginBloc,
            listener: (context, state) {
              _onStateChanged(state, context);
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  primary: true,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _topView(),
                        const SizedBox(
                          height: 100,
                        ),
                        _loginFormView(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _topView() {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _loginFormView() {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField.textField(
                  hint: "Email",
                  backgroundColor: AppColors.transparent,
                  validator: () => null,
                  textColor: AppColors.white,
                  borderColor: AppColors.white,
                  controller: _emailAddressController,
                  keyboardType: TextInputType.emailAddress,
                  isPasswordField: false,
                  isObsecured: false,
                  hasError: (state is LogInFormValidationErrorState)
                      ? state.validationModel.emailInputValidationError
                      : false),
              const SizedBox(
                height: 16,
              ),
              AppTextField.textField(
                  hint: "Password",
                  backgroundColor: AppColors.transparent,
                  controller: _passwordController,
                  maxLines: 1,
                  textColor: AppColors.white,
                  borderColor: AppColors.white,
                  validator: () => null,
                  onObscureTapped: () {
                    setState(() {
                      _isObsecuredText = !_isObsecuredText;
                    });
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        _isObsecuredText = !_isObsecuredText;
                        setState(() {});
                      },
                      icon: Icon(
                        _isObsecuredText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.white,
                      )),
                  isPasswordField: true,
                  isObsecured: _isObsecuredText,
                  hasError: (state is LogInFormValidationErrorState)
                      ? state.validationModel.passwordInputValidationError
                      : false),
              const SizedBox(
                height: 32,
              ),
              _loginButton(),
              Padding(
                padding: const EdgeInsets.only(top: 33),
                child: GestureDetector(
                  onTap: _showForgotPasswordView,
                  child: Text(
                    "Forgot your Password?",
                    style: AppStyles.boldLarge(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoggingInState) {
          return const Loader(
            color: AppColors.white,
          );
        }

        return AppButton(
            title: "Login",
            button: PrimaryButtonDecorator(),
            appButtonState: AppButtonState.enabled,
            onClick: _onLoginButtonClick);
      },
    );
  }

  _onLoginButtonClick() {
    if (_formKey.currentState!.validate()) {
      Utilities.dismissKeyboard();
      _loginBloc.add(LogInRequestEvent(
          email: _emailAddressController.text,
          password: _passwordController.text));
    }
  }

  _onStateChanged(LoginState state, BuildContext context) {
    if (state is LoggedInState) {
      // Navigator.pushReplacement(context, UserDashboardScreen.route());
      // move to your screen
    } else if (state is LoginApiErrorState) {
      Utilities.showSnackBar(context, state.errorMessage, SnackbarStyle.error);
    } else if (state is LogInFormValidationErrorState) {
      Utilities.showSnackBar(
          context,
          state.validationModel.formattedErrorMessage,
          SnackbarStyle.validationError);
    }
  }

  _showForgotPasswordView() {
    // Navigator.push(context, ForgotPasswordScreen.route());
    // show forgot password screen
  }
}

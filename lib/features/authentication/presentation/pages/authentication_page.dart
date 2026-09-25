import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/core/helpers/login_number.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:silab/features/registration/presentation/pages/registration_verification_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nimController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (_, __) => ModalRoute.of(context)?.isCurrent ?? true,
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(message: 'Sign In Success', type: AlertType.success),
            );

            context.goNamed('home');
          } else if (state is AuthenticationUnverified) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(message: state.message, type: AlertType.info),
            );

            context.pushNamed(
              'register-verify',
              extra: RegistrationVerificationPageExtra(email: state.email),
            );
          } else if (state is AuthenticationFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(message: state.message, type: AlertType.error),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/sisinfo-blue.png',
                    scale: 3,
                  ),
                  const SizedBox(height: 64),
                  CustomFormField(
                    controller: _nimController,
                    hintText: 'NIM',
                    suffixIcon: 'assets/image/email.png',
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    isObscure: false,
                    validator: validateLoginNumber,
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    suffixIcon: 'assets/image/password.png',
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isObscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Anda Belum Diisi!';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.pushNamed('forgot-password'),
                      child: const Text(
                        'Lupa password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3272CA),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return CustomLargeButton(
                        action: state is! AuthenticationLoading
                            ? () {
                                if (formKey.currentState!.validate()) {
                                  final String nim = _nimController.text.trim();
                                  final String password =
                                      _passwordController.text.trim();
                                  final LoginModel loginData =
                                      LoginModel(nim: nim, password: password);

                                  context
                                      .read<AuthenticationBloc>()
                                      .add(UserLogin(loginData: loginData));
                                }
                              }
                            : null,
                        label: state is! AuthenticationLoading
                            ? const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun?',
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed('register'),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3272CA),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/core/helpers/campus_email.dart';
import 'package:silab/features/password_reset/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:silab/features/password_reset/presentation/pages/reset_password_page.dart';
import 'package:silab/features/registration/presentation/pages/registration_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? _nim;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    final nim = nimFromCampusEmail(_emailController.text);
    if (nim != _nim) setState(() => _nim = nim);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context
        .read<ForgotPasswordBloc>()
        .add(SubmitForgotPassword(normalizeEmail(_emailController.text)));
  }

  void _showMessage(String message, AlertType type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar(message: message, type: type),
    );
  }

  void _backToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('authentication');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordCodeSent) {
            _showMessage(
              'Kode reset password dikirim ke ${state.reset.email}',
              AlertType.success,
            );

            context.pushNamed(
              'reset-password',
              extra: ResetPasswordPageExtra(
                email: state.reset.email,
                resendIn: state.reset.resendIn,
              ),
            );
          } else if (state is ForgotPasswordUnverified) {
            _showMessage(state.message, AlertType.info);

            context.pushNamed(
              'register-verify',
              extra: RegistrationVerificationPageExtra(email: state.email),
            );
          } else if (state is ForgotPasswordFailed) {
            _showMessage(state.message, AlertType.error);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/image/sisinfo-blue.png', scale: 3),
                    const SizedBox(height: 32),
                    const Text(
                      'Lupa Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Masukkan email kampus yang terdaftar di SILAB. '
                      'Kode untuk mengganti password dikirim ke email itu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0x991D1D1D)),
                    ),
                    const SizedBox(height: 24),
                    CustomFormField(
                      controller: _emailController,
                      hintText: 'Email kampus',
                      suffixIcon: 'assets/image/email.png',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                      isObscure: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email Anda Belum Diisi!';
                        }
                        if (!isEmailFormat(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    if (_nim != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'NIM: $_nim',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff3272CA),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        final isSubmitting = state is ForgotPasswordSubmitting;

                        return CustomLargeButton(
                          action: isSubmitting ? null : _submit,
                          label: isSubmitting
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text(
                                  'Kirim Kode',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                          'Ingat password?',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: _backToLogin,
                          child: const Text(
                            'Masuk',
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
      ),
    );
  }
}

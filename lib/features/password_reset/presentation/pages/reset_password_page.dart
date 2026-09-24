import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/presentation/bloc/reset_password/reset_password_bloc.dart';

class ResetPasswordPageExtra {
  final String email;
  final int resendIn;

  const ResetPasswordPageExtra({required this.email, this.resendIn = 0});
}

class ResetPasswordPage extends StatefulWidget {
  final ResetPasswordPageExtra extra;

  const ResetPasswordPage({super.key, required this.extra});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  static const int _codeLength = 6;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  Timer? _resendTimer;
  int _resendIn = 0;

  String get _email => widget.extra.email;

  @override
  void initState() {
    super.initState();
    _startResendCountdown(widget.extra.resendIn);
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _startResendCountdown(int seconds) {
    _resendTimer?.cancel();
    _resendIn = seconds;
    if (seconds <= 0) return;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _resendIn--);
      if (_resendIn <= 0) timer.cancel();
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ResetPasswordBloc>().add(
          SubmitNewPassword(
            ResetPasswordModel(
              email: _email,
              code: _codeController.text,
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
            ),
          ),
        );
  }

  void _showMessage(String message, AlertType type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar(message: message, type: type),
    );
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('authentication');
    }
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffBFD9EF)),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSucceeded) {
            _showMessage(state.message, AlertType.success);
            context.goNamed('authentication');
          } else if (state is ResetPasswordCodeResent) {
            _codeController.clear();
            _showMessage(
              'Kode baru dikirim ke ${state.reset.email}',
              AlertType.success,
            );
            setState(() => _startResendCountdown(state.reset.resendIn));
          } else if (state is ResetPasswordFailed) {
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
                      'Atur Password Baru',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: 'Masukkan 6 angka kode yang dikirim ke\n',
                        children: [
                          TextSpan(
                            text: _email,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff1D1D1D),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0x991D1D1D),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _codeController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      maxLength: _codeLength,
                      cursorColor: const Color(0xffFFBF01),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) => value?.length == _codeLength
                          ? null
                          : 'Masukkan 6 angka kode verifikasi!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 12,
                        color: Color(0xff1D1D1D),
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: '000000',
                        hintStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 12,
                          color: Color(0x261D1D1D),
                        ),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff3272CA)),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kode berlaku 10 menit.',
                      style: TextStyle(fontSize: 12, color: Color(0x801D1D1D)),
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      controller: _passwordController,
                      hintText: 'Password baru',
                      suffixIcon: 'assets/image/password.png',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      isObscure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Baru Belum Diisi!';
                        }
                        if (value.length < 8) {
                          return 'Password minimal 8 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Konfirmasi password baru',
                      suffixIcon: 'assets/image/password.png',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      isObscure: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Konfirmasi password tidak sama';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      builder: (context, state) {
                        final isSubmitting = state is ResetPasswordSubmitting ||
                            state is ResetPasswordSucceeded;

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
                                  'Simpan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      builder: (context, state) {
                        if (_resendIn > 0) {
                          return Text(
                            'Kirim ulang kode dalam $_resendIn detik',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0x801D1D1D),
                            ),
                          );
                        }

                        final isResending = state is ResetPasswordResending;

                        return TextButton(
                          onPressed: isResending
                              ? null
                              : () => context
                                  .read<ResetPasswordBloc>()
                                  .add(ResendResetCode(_email)),
                          child: Text(
                            isResending
                                ? 'Mengirim kode...'
                                : 'Kirim ulang kode',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3272CA),
                            ),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: _back,
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0x991D1D1D),
                        ),
                      ),
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

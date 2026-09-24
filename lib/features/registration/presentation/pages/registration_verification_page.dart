import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/registration/presentation/bloc/registration_verification/registration_verification_bloc.dart';

class RegistrationVerificationPageExtra {
  final String email;
  final int resendIn;

  const RegistrationVerificationPageExtra({
    required this.email,
    this.resendIn = 0,
  });
}

class RegistrationVerificationPage extends StatefulWidget {
  final RegistrationVerificationPageExtra extra;

  const RegistrationVerificationPage({super.key, required this.extra});

  @override
  State<RegistrationVerificationPage> createState() =>
      _RegistrationVerificationPageState();
}

class _RegistrationVerificationPageState
    extends State<RegistrationVerificationPage> {
  static const int _codeLength = 6;

  final TextEditingController _codeController = TextEditingController();
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
    final code = _codeController.text;

    if (code.length != _codeLength) {
      _showMessage('Masukkan 6 angka kode verifikasi!', AlertType.error);
      return;
    }

    context
        .read<RegistrationVerificationBloc>()
        .add(SubmitVerificationCode(email: _email, code: code));
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
      body: BlocListener<RegistrationVerificationBloc,
          RegistrationVerificationState>(
        listener: (context, state) {
          if (state is VerificationSucceeded) {
            _showMessage(state.message, AlertType.success);
            context.goNamed('home');
          } else if (state is VerificationCodeResent) {
            _codeController.clear();
            _showMessage(
              'Kode baru dikirim ke ${state.registration.email}',
              AlertType.success,
            );
            setState(
              () => _startResendCountdown(state.registration.resendIn),
            );
          } else if (state is VerificationFailed) {
            _codeController.clear();
            _showMessage(state.message, AlertType.error);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/image/sisinfo-blue.png', scale: 3),
                  const SizedBox(height: 32),
                  const Text(
                    'Verifikasi Email',
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
                  TextField(
                    controller: _codeController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: _codeLength,
                    cursorColor: const Color(0xffFFBF01),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      if (value.length == _codeLength) _submit();
                    },
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
                  const SizedBox(height: 24),
                  BlocBuilder<RegistrationVerificationBloc,
                      RegistrationVerificationState>(
                    builder: (context, state) {
                      final isSubmitting = state is VerificationSubmitting ||
                          state is VerificationSucceeded;

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
                                'Verifikasi',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<RegistrationVerificationBloc,
                      RegistrationVerificationState>(
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

                      final isResending = state is VerificationResending;

                      return TextButton(
                        onPressed: isResending
                            ? null
                            : () => context
                                .read<RegistrationVerificationBloc>()
                                .add(ResendVerificationCode(_email)),
                        child: Text(
                          isResending ? 'Mengirim kode...' : 'Kirim ulang kode',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/core/helpers/campus_email.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/presentation/bloc/registration/registration_bloc.dart';
import 'package:silab/features/registration/presentation/pages/registration_verification_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _nim;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    final nim = nimFromCampusEmail(_emailController.text);
    if (nim != _nim) setState(() => _nim = nim);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<RegistrationBloc>().add(
          SubmitRegistration(
            RegisterModel(
              email: normalizeEmail(_emailController.text),
              fullname: _fullnameController.text.trim(),
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
            ),
          ),
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
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationCodeSent) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(
                message:
                    'Kode verifikasi dikirim ke ${state.registration.email}',
                type: AlertType.success,
              ),
            );

            context.pushNamed(
              'register-verify',
              extra: RegistrationVerificationPageExtra(
                email: state.registration.email,
                resendIn: state.registration.resendIn,
              ),
            );
          } else if (state is RegistrationFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar(message: state.message, type: AlertType.error),
            );
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
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1D1D1D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Gunakan email kampus @webmail.uad.ac.id',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0x991D1D1D)),
                    ),
                    const SizedBox(height: 24),
                    CustomFormField(
                      controller: _emailController,
                      hintText: 'Email kampus',
                      suffixIcon: 'assets/image/email.png',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      isObscure: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email Anda Belum Diisi!';
                        }
                        if (nimFromCampusEmail(value) == null) {
                          return 'Gunakan email kampus namadepanNIM@webmail.uad.ac.id';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _nim != null
                              ? 'NIM: $_nim'
                              : 'NIM diambil otomatis dari email kampus',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: _nim != null
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: _nim != null
                                ? const Color(0xff3272CA)
                                : const Color(0x801D1D1D),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      controller: _fullnameController,
                      hintText: 'Nama lengkap',
                      suffixIcon: null,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      isObscure: false,
                      validator: (value) {
                        final name = value?.trim() ?? '';
                        if (name.isEmpty) return 'Nama Lengkap Belum Diisi!';
                        if (name.length < 3) {
                          return 'Nama lengkap minimal 3 karakter';
                        }
                        return null;
                      },
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
                        if (value.length < 8) {
                          return 'Password minimal 8 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomFormField(
                      controller: _confirmPasswordController,
                      hintText: 'Konfirmasi password',
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
                    BlocBuilder<RegistrationBloc, RegistrationState>(
                      builder: (context, state) {
                        final isSubmitting = state is RegistrationSubmitting;

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
                                  'Daftar',
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
                          'Sudah punya akun?',
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

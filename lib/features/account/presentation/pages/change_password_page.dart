import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';
import 'package:silab/features/account/presentation/bloc/change_password/change_password_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangePasswordBloc>().add(
          SubmitPasswordChange(
            ChangePasswordModel(
              oldPassword: _oldPasswordController.text,
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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height -
            (Scaffold.maybeOf(context)?.appBarMaxHeight ?? 0),
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSucceeded) {
              _showMessage(state.message, AlertType.success);
              context.pop();
            } else if (state is ChangePasswordFailed) {
              _showMessage(state.message, AlertType.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
              top: 24,
              bottom: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Setelah password diganti, perangkat lain yang masuk '
                    'dengan akun ini akan dikeluarkan.',
                    style: TextStyle(fontSize: 14, color: Color(0x991D1D1D)),
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _oldPasswordController,
                    hintText: 'Password lama',
                    suffixIcon: 'assets/image/password.png',
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isObscure: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Password Lama Belum Diisi!'
                        : null,
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
                      if (value == _oldPasswordController.text) {
                        return 'Password baru harus berbeda dari password lama';
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
                    validator: (value) => value != _passwordController.text
                        ? 'Konfirmasi password tidak sama'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    builder: (context, state) {
                      final isSubmitting = state is ChangePasswordSubmitting ||
                          state is ChangePasswordSucceeded;

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

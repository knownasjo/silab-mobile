import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/common/widgets/custom_large_button.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/account/presentation/bloc/edit_profile/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final String initialName;

  const EditProfilePage({super.key, this.initialName = ''});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullnameController =
      TextEditingController(text: widget.initialName);

  @override
  void dispose() {
    _fullnameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<EditProfileBloc>().add(
          SubmitProfile(
            _fullnameController.text.trim().replaceAll(RegExp(r'\s+'), ' '),
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
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSucceeded) {
              _showMessage(state.message, AlertType.success);
              context.pop();
            } else if (state is EditProfileFailed) {
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
                    'Nama lengkap tampil di presensi, pembayaran, dan daftar '
                    'teman kelas.',
                    style: TextStyle(fontSize: 14, color: Color(0x991D1D1D)),
                  ),
                  const SizedBox(height: 16),
                  CustomFormField(
                    controller: _fullnameController,
                    hintText: 'Nama lengkap',
                    suffixIcon: null,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                    isObscure: false,
                    validator: (value) {
                      final name = value?.trim() ?? '';
                      if (name.isEmpty) return 'Nama Lengkap Belum Diisi!';
                      if (name.length < 3) {
                        return 'Nama lengkap minimal 3 karakter';
                      }
                      if (name.length > 100) {
                        return 'Nama lengkap maksimal 100 karakter';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 8),
                    child: Text(
                      'NIM dan email tidak bisa diubah.',
                      style: TextStyle(fontSize: 12, color: Color(0x801D1D1D)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<EditProfileBloc, EditProfileState>(
                    builder: (context, state) {
                      final isSubmitting = state is EditProfileSubmitting ||
                          state is EditProfileSucceeded;

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

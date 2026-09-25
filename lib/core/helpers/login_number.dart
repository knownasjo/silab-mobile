const String staffUseWebMessage =
    'Akun dosen dan laboran memakai SILAB versi web.';

String? validateLoginNumber(String? value) {
  if (value == null || value.isEmpty) return 'NIM Anda Belum Diisi!';
  if (value.length == 8) return staffUseWebMessage;
  if (value.length < 10) return 'Masukkan NIM yang Valid!';
  return null;
}

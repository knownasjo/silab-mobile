# SILAB Mobile

Aplikasi Flutter untuk **mahasiswa** praktikum SILAB — Program Studi Sistem
Informasi, Universitas Ahmad Dahlan. Terhubung ke `silab-backend` yang sama
dengan web admin (`silab-admin`), jadi presensi yang dipindai di aplikasi
langsung muncul di rekap web, dan pembayaran yang dikonfirmasi laboran di web
langsung terlihat di aplikasi.

Akun laboran, asisten, dan dosen ditolak saat login: fitur aplikasi ini
(presensi, pilih kelas) hanya untuk mahasiswa.

## Kebutuhan

- Flutter 3.24.x (Dart 3.5.4), sesuai `environment.sdk` di `pubspec.yaml`
- `silab-backend` berjalan (lihat README-nya), bawaan di port 3000
- Untuk Android: Android SDK dengan platform 35 dan **JDK 17**. Gradle 8.10.2
  belum mendukung JDK 21, jadi arahkan `JAVA_HOME` ke JDK 17 bila JDK bawaan
  laptop lebih baru

## Menjalankan

Android punya dua flavor, `prod` (nama aplikasi "SILAB") dan `dev` ("SILAB
Dev", `lib/main_dev.dart`), jadi `--flavor` wajib untuk Android. iOS, web,
dan desktop tidak memakai flavor.

```bash
flutter pub get
flutter run --flavor prod          # emulator Android
flutter run                        # simulator iOS, web, desktop
```

Alamat backend diatur lewat `--dart-define=API_BASE_URL=...`
(`lib/app_config.dart`):

| Perangkat | Alamat | Perlu flag? |
|---|---|---|
| Emulator Android | `http://10.0.2.2:3000` | tidak (bawaan) |
| Simulator iOS, web, desktop | `http://localhost:3000` | tidak (bawaan) |
| HP fisik | `http://<IP-laptop>:3000` | **ya** |

### APK untuk HP

HP dan laptop harus berada di Wi-Fi yang sama. Cari IP laptop dengan
`ipconfig getifaddr en0` (macOS), lalu:

```bash
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
flutter build apk --flavor prod -t lib/main.dart \
  --dart-define=API_BASE_URL=http://192.168.1.10:3000
```

Hasilnya `build/app/outputs/flutter-apk/app-prod-release.apk`. Kirim file
itu ke HP, izinkan "instal dari sumber tidak dikenal", lalu pasang. Alamat
server tertanam di APK, jadi **build ulang bila IP laptop berubah**.

Bila HP tidak bisa tersambung:

- Buka `http://<IP-laptop>:3000` di browser HP. Harus muncul respons dari
  backend.
- Pastikan port 3000 diizinkan firewall laptop.
- Wi-Fi kampus atau publik sering memblokir koneksi antarperangkat
  (*client isolation*). Pakai hotspot HP atau router sendiri.

### Konfigurasi Android

`mobile_scanner` 6.0.x memakai CameraX 1.5, yang membutuhkan versi berikut.
Versi bawaan proyek (AGP 7.3.0, Gradle 7.6.3, Kotlin 1.8.0, minSdk 21) gagal
di-build:

| | Versi |
|---|---|
| Android Gradle Plugin | 8.7.3 (`android/settings.gradle`) |
| Gradle | 8.10.2 (`android/gradle/wrapper/gradle-wrapper.properties`) |
| Kotlin | 2.1.0 |
| compileSdk / minSdk | 35 / 23 (Android 6.0) |

`flutter_local_notifications` mewajibkan *core library desugaring*, jadi
fitur itu diaktifkan di `android/app/build.gradle`. Plugin Google Services
(sisa FlutterFire) dilepas karena aplikasi tidak memakai Firebase dan
`google-services.json` tidak ada.

## Akun uji

| NIM | Password |
|---|---|
| 2000016099 | mahasiswa001 |

## Alur yang tersambung ke web

1. Laboran membuat pengumuman bertipe **Practicum** di web → di aplikasi,
   tombol "Pelajari lebih lanjut" pada pengumuman itu membuka pendaftaran
   praktikum. Pengumuman tipe lain membuka halaman detail.
2. Mahasiswa memilih mata kuliah → `POST /activation` → status "Belum Lunas"
   di Profil → Status Pembayaran.
3. Laboran mengonfirmasi pembayaran di web (boleh sekaligus menetapkan kelas)
   → status menjadi "Lunas".
4. Bila kelas belum ditetapkan, mahasiswa memilih kelas sendiri (tombol
   "Pilih Kelas"). Mata kuliah harus lunas, satu kelas per mata kuliah, kuota
   belum penuh.
5. Kelas muncul di Beranda dan Jadwal.
6. Asisten membuka sesi presensi dan menampilkan QR di web; QR berganti setiap
   10 detik. Di Detail Kelas, mahasiswa menekan ikon scan pada pertemuan yang
   sesinya dibuka. Tombol scan tidak membuka kamera bila sesi belum dibuka
   atau presensi sudah tercatat.
7. Detail Kelas diperbarui real-time lewat `GET /class/:id/events`. Begitu
   asisten membuka sesi, mahasiswa bisa langsung scan tanpa menarik layar
   untuk refresh. Bila sesi ditutup saat kamera masih terbuka, halaman scan
   tertutup sendiri dengan pesan "Sesi presensi sudah ditutup oleh asisten."
   Perubahan presensi manual oleh laboran juga langsung tampil.

Status presensi mengikuti aturan yang sama dengan web: `submitted_at` kosong
berarti **belum presensi**; bila terisi, `is_attended` menentukan **hadir**
atau **tidak hadir**.

## Struktur

Clean architecture per fitur (`lib/features/<fitur>/{data,domain,presentation}`)
dengan BLoC. Semua permintaan ke backend lewat satu kelas,
`lib/core/network/api_client.dart`, yang mengurus alamat server, token,
JSON, dan pesan error. Pesan error backend diteruskan apa adanya.

Access token berlaku 15 menit. Bila backend membalas `jwt expired`,
`ApiClient` menukar refresh token di `POST /auth/refresh`, menyimpan token
baru, lalu mengulang permintaan sekali. Beberapa permintaan yang gagal
bersamaan hanya memicu satu refresh. `jwt expired` baru sampai ke halaman bila
refresh token juga ditolak (sesi lewat 1 hari), dan halaman itu mengarahkan ke
login. Saat aplikasi dibuka, yang diperiksa adalah masa berlaku refresh token
(`getSessionExpiry`), bukan access token.

`ApiClient.listen()` membuka stream SSE dengan token dan aturan refresh yang
sama, lalu tersambung ulang sendiri bila koneksi putus atau tidak ada data
selama 60 detik. `UserMeetingsBloc` berlangganan lewat `WatchUserMeetings`
saat Detail Kelas dibuka dan berhenti lewat `StopWatchingUserMeetings` saat
ditutup. Setiap event memicu `RefreshUserMeetings`, yang memuat ulang tanpa
state loading agar daftar tidak berkedip. Saat aplikasi kembali dari
background, stream dibuka ulang karena koneksi lama bisa sudah diputus sistem.

Entity memakai `freezed`/`json_serializable`. Setelah mengubah entity:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Jangan menggabungkan `--build-filter` dengan `--delete-conflicting-outputs`:
file generate milik entity lain ikut terhapus.

## Tes

```bash
flutter test                                          # tanpa server
flutter test test/live --dart-define=API_BASE_URL=http://localhost:3000
```

- `test/core/network/api_client_test.dart` — token, body, penanganan error,
  refresh token, dan stream SSE (token, refresh, tersambung ulang, berhenti
  saat dibatalkan)
- `test/features/authentication/session_expiry_test.dart` — aplikasi yang
  dibuka setelah 15 menit tetap masuk; setelah 1 hari diarahkan ke login
- `test/features/backend_contract_test.dart` — setiap entity membaca contoh
  respons asli backend
- `test/live/` — alur mahasiswa terhadap backend yang sedang berjalan; hanya
  membaca data, dilewati bila `API_BASE_URL` tidak diberikan

## Catatan

- Mahasiswa diminta login lagi 1 hari setelah login, saat refresh token
  habis. Token disimpan di `SharedPreferences`, bukan penyimpanan terenkripsi.
- Aplikasi mengizinkan HTTP tanpa TLS (`usesCleartextTraffic` di Android,
  `NSAllowsArbitraryLoads` di iOS) karena backend lab berjalan di jaringan
  lokal. Untuk rilis publik, pakai HTTPS dan hapus pengecualian itu.
- `flutter_local_notifications` terdaftar di `pubspec.yaml` tetapi belum
  dipakai kode mana pun, begitu juga meta-data notifikasi Firebase di
  `AndroidManifest.xml`. Bila notifikasi tidak direncanakan, hapus
  keduanya; desugaring di `android/app/build.gradle` lalu bisa ikut dihapus.
- Detail Kelas: tab "Classmates" menampilkan nama teman sekelas
  (`GET /class/:id/classmates`, diri sendiri ditandai "Anda"). Tab "Modul"
  menampilkan "Segera Hadir" (`core/common/widgets/coming_soon.dart`) karena
  backend belum menyimpan modul.
- Sengaja dibiarkan: menu "Riwayat Pembayaran" belum punya halaman, dan total
  harga di ringkasan pendaftaran adalah tarif tetap Rp5.000 per mata kuliah
  yang ditulis di UI.
- Beberapa entity lama tidak dipakai lagi (misalnya `ClassEntity`,
  `ClassResponseEntity`, dan `RegisteredClassEntity` di `features/`).

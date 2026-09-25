# SILAB Mobile

Aplikasi Flutter untuk **mahasiswa** praktikum SILAB — Program Studi Sistem
Informasi, Universitas Ahmad Dahlan. Terhubung ke `silab-backend` yang sama
dengan web admin (`silab-admin`), jadi presensi yang dipindai di aplikasi
langsung muncul di rekap web, dan pembayaran yang dikonfirmasi laboran di web
langsung terlihat di aplikasi.

Akun dosen dan laboran ditolak saat login dengan pesan "Akun dosen dan laboran
memakai SILAB versi web.", karena fitur aplikasi ini (presensi, pilih kelas)
hanya untuk mahasiswa. Asisten tetap masuk sebagai mahasiswa biasa. Penolakan
terjadi di dua tempat (`lib/core/helpers/login_number.dart`):

- Nomor 8 angka (format NIY dosen dan laboran) ditolak di form sebelum
  permintaan dikirim ke server. NIM mahasiswa tetap 10 angka.
- Bila login berhasil tetapi `GET /auth/me` menyebut role selain MAHASISWA,
  token tidak disimpan dan pesan yang sama tampil di snackbar.

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

## Pendaftaran akun

Mahasiswa membuat akun sendiri dari halaman login ("Belum punya akun?
Daftar"):

1. Isi email kampus `namadepanNIM@webmail.uad.ac.id`, nama lengkap, password
   (min. 8 karakter), dan konfirmasinya. NIM tampil otomatis dari email
   (`lib/core/helpers/campus_email.dart`) dan tidak bisa diubah.
2. Backend mengirim kode 6 angka ke email itu. Layar Verifikasi mengirim kode
   begitu 6 angka terisi; tombol "Kirim ulang kode" aktif setelah hitung mundur
   60 detik.
3. Kode benar → token disimpan dan mahasiswa langsung masuk ke Beranda.

Login dengan akun yang belum diverifikasi (backend membalas 403 dengan
`data.email`) membuka layar Verifikasi untuk email tersebut. Fitur ada di
`lib/features/registration` dengan dua bloc: `RegistrationBloc` (form) dan
`RegistrationVerificationBloc` (kode dan kirim ulang). Avatar di Profil dan
daftar Classmates memakai inisial dua kata pertama nama lengkap
(`lib/core/helpers/initials.dart`).

## Lupa password

Dari halaman login, "Lupa password?" membuka dua layar
(`lib/features/password_reset`):

1. **Lupa Password**: isi email akun (NIM tampil bila formatnya email kampus),
   lalu "Kirim Kode". Email yang belum terdaftar dibalas "Email ini belum
   terdaftar di SILAB."; email yang masih menunggu verifikasi membuka layar
   Verifikasi pendaftaran.
2. **Atur Password Baru**: kode 6 angka, password baru (min. 8), dan
   konfirmasinya dalam satu layar, lalu "Simpan". Kode yang salah tidak
   menghapus isian password. "Kirim ulang kode" aktif setelah hitung mundur 60
   detik.
3. Berhasil → kembali ke Login dengan pesan "Password berhasil diubah, silakan
   masuk."

Hanya untuk akun mahasiswa; laboran dan dosen meminta laboran lain mengganti
password mereka. Bloc-nya `ForgotPasswordBloc` (minta kode) dan
`ResetPasswordBloc` (simpan password dan kirim ulang kode).

Mengganti password mencabut semua sesi lama akun itu. HP lain yang sedang
login dengan akun tersebut kembali ke halaman login dalam 1–2 detik dengan
pesan "Sesi Anda berakhir, silakan masuk kembali." (lihat "Struktur").

## Edit profil dan ganti password

Halaman Profil punya dua menu baru (`lib/features/account`):

- **Edit Profil** (`/home/edit-profil`): nama lengkap terisi nama sekarang,
  3–100 karakter, lalu `PUT /auth/me`. NIM dan email tidak bisa diubah.
  Sekembalinya ke Profil, `UserDetailsBloc` dimuat ulang diam-diam
  (`RefreshUserDetails`), jadi Profil dan sapaan di Beranda langsung memakai
  nama baru.
- **Ganti Password** (`/home/ganti-password`): password lama, password baru
  (min. 8, harus berbeda dari yang lama), dan konfirmasi, lalu
  `PUT /auth/me/password`. Token baru dari server disimpan
  (`AccountRepositoryImpl`), jadi HP ini tetap masuk dan stream real-time
  tersambung lagi dengan token baru; HP lain dengan akun yang sama kembali ke
  halaman login.

Bloc-nya `EditProfileBloc` dan `ChangePasswordBloc`; keduanya mengabaikan
tombol Simpan yang ditekan lagi saat permintaan masih berjalan.

## Asisten praktikum

Mahasiswa yang ditugaskan laboran sebagai asisten kelas tetap memakai aplikasi
ini sebagai mahasiswa biasa (daftar praktikum lain, bayar, scan presensi). Di
Profil muncul bagian "Asisten Praktikum" berisi kelas yang ia pegang beserta
jadwalnya, dengan keterangan bahwa kelas dikelola lewat web SILAB. Datanya dari
`GET /class` (untuk mahasiswa backend hanya mengembalikan kelas yang ia
pegang), lewat `AssistedClassesBloc` di `lib/features/user_details`. Bagian ini
tidak tampil bila ia tidak memegang kelas, dan ikut berubah tanpa refresh saat
laboran menambah atau menghapusnya (event `class`).

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
   sesinya dibuka. Daftar pertemuan di sana adalah urutan dari server
   (menurut judul, Pertemuan 2 sebelum Pertemuan 10) yang dibalik, jadi nomor
   terbesar ada di atas. Tombol scan tidak membuka kamera bila sesi belum dibuka
   atau presensi sudah tercatat.
7. Semua tampilan diperbarui real-time lewat `GET /events`, tanpa menarik
   layar untuk refresh:

   | Tampilan | Berubah saat |
   |---|---|
   | Pengumuman di Beranda | laboran membuat, mengubah, atau menghapus pengumuman |
   | Detail pengumuman | isinya diubah; bila dihapus, halaman tertutup dengan pesan "Pengumuman ini sudah dihapus." |
   | Status Pembayaran | laboran mengonfirmasi atau membatalkan pembayaran |
   | Kelas Terdaftar, Jadwal | laboran menetapkan atau memindah kelas, mengubah atau menghapus kelas, mengubah nama mata kuliah atau dosen pengampunya, atau mahasiswa memilih kelas |
   | Banner & halaman Pilih Kelas | pembayaran dikonfirmasi, kuota kelas yang bisa dipilih berubah, kelas baru |
   | Pendaftaran Praktikum | mata kuliah baru |
   | Detail Kelas (Presensi, Classmates) | sesi dibuka/ditutup, presensi diubah laboran, peserta kelas berubah |
   | Kartu kelas di Detail Kelas | laboran mengubah nama, hari, atau sesi kelas; bila kelas dihapus atau mahasiswa dipindah ke kelas lain, halaman berganti menjadi "Anda sudah tidak terdaftar di kelas ini." dengan tombol Kembali ke Beranda |

   Bila sesi ditutup saat kamera masih terbuka, halaman scan tertutup sendiri
   dengan pesan "Sesi presensi sudah ditutup oleh asisten."

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
bersamaan hanya memicu satu refresh. Bila refresh token ditolak server (4xx:
sesi lewat 1 hari, password diganti, atau akun dihapus), `ApiClient` menghapus
token lalu mengirim sinyal `sessionEnded`; `AuthenticationBloc` mendengarnya
lewat `WatchSessionEndedUsecase` dan memancarkan `SessionExpired`, sehingga
`ScaffoldPage` membuka halaman login. Permintaan yang gagal itu dibalas "Sesi
berakhir, silakan masuk kembali.". Server error (5xx) saat refresh tidak
mengeluarkan pengguna. Saat aplikasi dibuka, yang diperiksa adalah masa
berlaku refresh token (`getSessionExpiry`), bukan access token.

Pembaruan real-time ada di `lib/features/realtime`. `ApiClient.listen()`
membuka stream SSE dengan token dan aturan refresh yang sama, lalu tersambung
ulang sendiri bila koneksi putus atau tidak ada data selama 60 detik.
`RealtimeBloc` membuka satu stream selama pengguna berada di dalam aplikasi;
widget `RealtimeSync`, yang membungkus isi `ScaffoldPage`, meneruskan setiap
event ke bloc yang datanya terpengaruh. Stream ditutup saat logout dan dibuka
ulang saat aplikasi kembali dari background, karena koneksi lama bisa sudah
diputus sistem.

Setiap bloc data punya event `Refresh…` (misalnya `RefreshUserRegisteredClass`)
yang memuat ulang tanpa state loading, jadi daftar tidak berkedip. Refresh
diabaikan bila data belum pernah dibuka (state masih `Initial`), gagalnya
tidak menghapus data yang sedang tampil, dan beberapa refresh berjalan
berurutan (`sequential()` di `lib/core/helpers/event_transformers.dart`).

Halaman Detail Kelas dibuka dengan data kelas dari kartu di Beranda. Supaya
kartu di atasnya tidak memakai jadwal lama, `RegisteredClassGuard`
(`lib/features/classes/presentation/widgets/registered_class_guard.dart`)
mengambil kelas yang sama dari `UserRegisteredClassBloc`, yang dimuat ulang
oleh event `activation`. Bila kelas itu sudah tidak ada di daftar, halaman
menampilkan pemberitahuan alih-alih tab Presensi dan Classmates.

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
  refresh token (termasuk sesi berakhir: token dihapus, sinyal dikirim sekali),
  dan stream SSE (token, refresh, isi event, tersambung ulang,
  berhenti saat dibatalkan)
- `test/features/realtime/` — `RealtimeBloc` (koneksi pertama, tersambung
  ulang, logout) dan refresh diam-diam di bloc (tanpa loading, data lama tetap
  tampil bila gagal, event kelas lain diabaikan, pengumuman dihapus)
- `test/features/registration/registration_test.dart` — NIM dari email
  kampus, inisial nama, repository (token disimpan hanya bila kode benar),
  login akun belum terverifikasi membawa email, urutan state kedua bloc, form
  Daftar menolak isian kosong, dan layar kode (hitung mundur, kirim otomatis)
- `test/features/user_details/assisted_classes_test.dart` — kelas asisten
  dibaca dari `GET /class`, refresh diam-diam, dan bagian Profil hanya tampil
  bila memegang kelas
- `test/features/account/account_test.dart` — `PUT /auth/me` dengan token
  login, token baru disimpan hanya bila ganti password berhasil, urutan state
  kedua bloc, profil dimuat ulang diam-diam, dan validasi kedua layar (nama
  kosong/pendek, password kosong, pendek, sama dengan yang lama, konfirmasi
  beda)
- `test/features/password_reset/password_reset_test.dart` — format email,
  repository (email belum terdaftar, akun belum diverifikasi membawa email),
  urutan state kedua bloc, simpan tidak dikirim dua kali, dan kedua layar
  (NIM dari email, validasi isian, kode salah tidak menghapus password,
  hitung mundur)
- `test/features/authentication/staff_login_test.dart` — nomor 8 angka
  ditolak di form tanpa menghubungi server, role DOSEN/LABORAN dari server
  ditolak tanpa menyimpan token, dan mahasiswa tetap bisa masuk
- `test/features/authentication/session_expiry_test.dart` — aplikasi yang
  dibuka setelah 15 menit tetap masuk; setelah 1 hari diarahkan ke login;
  sesi yang dicabut server saat aplikasi dipakai juga diarahkan ke login
- `test/features/classes/registered_class_guard_test.dart` — Detail Kelas
  memakai data kelas terbaru dari `GET /class/me`, menampilkan pemberitahuan
  bila kelasnya sudah tidak ada, dan tidak salah menganggap kelas dihapus saat
  pemuatan ulang gagal
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

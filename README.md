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
   (min. 8 karakter, tanpa spasi), dan konfirmasinya. NIM tampil otomatis dari email
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
2. **Atur Password Baru**: kode 6 angka, password baru (min. 8, tanpa spasi), dan
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
  (min. 8, tanpa spasi, harus berbeda dari yang lama), dan konfirmasi, lalu
  `PUT /auth/me/password`. Token baru dari server disimpan
  (`AccountRepositoryImpl`), jadi HP ini tetap masuk dan stream real-time
  tersambung lagi dengan token baru; HP lain dengan akun yang sama kembali ke
  halaman login.

Bloc-nya `EditProfileBloc` dan `ChangePasswordBloc`; keduanya mengabaikan
tombol Simpan yang ditekan lagi saat permintaan masih berjalan.

Sejak 1 Oktober 2026, password baru di Daftar, Atur Password Baru, dan Ganti
Password tidak boleh mengandung spasi di mana pun: form menampilkan "Password
tidak boleh mengandung spasi" sebelum mengirim, dan server menolaknya dengan
400. Halaman Login tidak memeriksa spasi; password dikirim setelah spasi di
awal dan akhir dibuang, dan karena password baru tidak mungkin berspasi, hal
itu tidak lagi membuat login gagal. Tombol login bertuliskan "Masuk", pesan
berhasilnya "Berhasil masuk", dan pesan jarang saat server tidak mengirim
token "Terjadi kesalahan, coba lagi."

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
   praktikum. Pengumuman tipe lain membuka halaman detail. Warna kartu di
   Beranda mengikuti jenisnya, dengan label jenis di pojok kiri atas (nama
   jenis sama dengan di web):

   | Jenis | Warna kartu |
   |---|---|
   | Pengumuman (`BASIC`, juga jenis yang tidak dikenal) | merah `#FE2F60` |
   | Pendaftaran Praktikum (`PRACTICUM`) | biru `#3272CA` |
   | Pendaftaran Inhal (`INHALL`) | ungu `#7239EA` |
   | Pendaftaran Asisten Praktikum (`ASSISTANT`) | hijau `#27A149` |

   Pengumuman jenis Pengumuman bisa ditujukan laboran ke mata kuliah tertentu.
   Server hanya mengirimkannya ke mahasiswa yang mendaftar mata kuliah itu di
   semester aktif dan asisten kelasnya, jadi aplikasi tidak perlu menyaring
   sendiri.

   Kartu setinggi 170 px, jadi judul dipotong setelah 2 baris dan isi setelah
   3 baris dengan "…"; isi lengkap ada di halaman detail. Pemetaannya di
   `announcement/presentation/widgets/announcement_type_style.dart`.
2. Mahasiswa memilih mata kuliah → `POST /activation` → status "Belum Lunas"
   di Profil → Pembayaran & Kelas. Di daftar pilihan, kode mata kuliah (9 angka)
   tampil kecil di bawah nama supaya mudah dicocokkan dengan KRS. Selama masih
   Belum Lunas, pendaftaran bisa dibatalkan (lihat "Batalkan pendaftaran").
3. Laboran mengonfirmasi pembayaran di web (boleh sekaligus menetapkan kelas,
   boleh juga dikosongkan) → status menjadi "Lunas".
4. Bila kelas belum ditetapkan, banner di Beranda dan tombol "Pilih Kelas" di
   Pembayaran & Kelas mengajak mahasiswa memilih kelas sendiri. Setelah
   disimpan, aplikasi kembali ke halaman asalnya (Beranda atau Pembayaran &
   Kelas). Mata kuliah harus lunas, satu kelas
   per mata kuliah, kuota belum penuh, dan jadwalnya tidak bentrok dengan kelas
   lain yang ia ikuti atau pegang sebagai asisten. Penolakan server, misalnya
   "Jadwal bentrok: ... yang Anda ikuti." atau kelas yang baru saja penuh
   karena direbut mahasiswa lain, tampil sebagai pesan merah setelah menekan
   Simpan; aplikasi tidak perlu diubah untuk itu. Bila laboran membatalkan
   pembayarannya sebelum ada presensi, kelas itu hilang dari Beranda dan
   Jadwal lewat event `class` dan `activation`.
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
   | Pengumuman di Beranda | laboran membuat, mengubah, atau menghapus pengumuman; mahasiswa mendaftar atau membatalkan mata kuliah, pembayarannya berubah, atau ia diangkat/dilepas sebagai asisten (karena ada pengumuman untuk mata kuliah tertentu) |
   | Detail pengumuman | isinya diubah; bila dihapus, halaman tertutup dengan pesan "Pengumuman ini sudah dihapus." |
   | Pembayaran & Kelas | laboran mengonfirmasi atau membatalkan pembayaran, menghapus pendaftaran yang belum bayar, menetapkan atau memindah kelas, mengubah atau menghapus kelas, atau membuat kelas baru; mahasiswa memilih kelas |
   | Kelas Terdaftar, Jadwal | laboran menetapkan atau memindah kelas, mengubah atau menghapus kelas, mengubah nama mata kuliah atau dosen pengampunya, atau mahasiswa memilih kelas |
   | Banner & halaman Pilih Kelas | pembayaran dikonfirmasi, kuota kelas yang bisa dipilih berubah, kelas baru |
   | Pendaftaran Praktikum | mata kuliah baru, diubah, atau dihapus laboran |
   | Detail Kelas (Presensi, Classmates) | pertemuan ditambah, diubah judulnya, atau dihapus, sesi dibuka/ditutup, presensi diubah laboran, peserta kelas berubah |
   | Kartu kelas di Detail Kelas | laboran mengubah nama, hari, atau sesi kelas; bila kelas dihapus, mahasiswa dipindah ke kelas lain, atau semesternya selesai, halaman berganti menjadi "Anda sudah tidak terdaftar di kelas ini." dengan tombol Kembali ke Beranda |
   | Semua tampilan di atas | laboran memulai semester baru |

   Bila sesi ditutup saat kamera masih terbuka, halaman scan tertutup sendiri
   dengan pesan "Sesi presensi sudah ditutup oleh asisten."
8. Aplikasi hanya menampilkan semester (periode akademik) yang sedang aktif;
   backend yang menyaring kelas, pendaftaran mata kuliah, dan kelas asisten.
   Saat laboran memulai semester baru di web, backend menutup sesi presensi
   yang masih terbuka lalu mengirim event `period`, dan semua tampilan dimuat
   ulang: kelas dan jadwal semester lama hilang dari Beranda dan Jadwal,
   Pembayaran & Kelas kosong, dan mahasiswa mendaftar ulang mata kuliah untuk semester
   baru. Mengulang mata kuliah yang pernah diambil diperbolehkan. Data semester
   lama tetap tersimpan dan hanya bisa dilihat di web.

### Pembayaran & Kelas

Menu Profil berisi Edit Profil, Ganti Password, **Pembayaran & Kelas**, dan
Keluar. Menu "Riwayat Pembayaran" dihapus pada 1 Oktober 2026 karena belum
punya halaman. Halaman Pembayaran & Kelas (route `payment-status`) memuat
pendaftaran semester aktif dari `GET /activation`. Tiap kotak mata kuliah
punya baris **Kelas** yang dibaca dari `registered_class` dan
`available_classes` di respons yang sama, jadi server tidak diubah:

| Keadaan | Baris Kelas |
|---|---|
| sudah punya kelas (dipilih sendiri atau ditetapkan laboran, walau belum lunas) | `Kelas: A · Senin, 08:00 - 10:00` (biru) |
| lunas, belum punya kelas, mata kuliah sudah punya kelas | `Kelas: belum dipilih` |
| lunas, mata kuliah belum punya kelas sama sekali | `Kelas: belum tersedia` |
| belum lunas | `Kelas: bisa dipilih setelah lunas` |

Tombol "Pilih Kelas" di bawah daftar membuka halaman Pilih Kelas dengan
`pushNamed`, jadi setelah kelas disimpan dan OK ditekan, aplikasi kembali ke
Pembayaran & Kelas dengan baris Kelas yang sudah diperbarui. Bila Pilih Kelas
dibuka dari banner Beranda, aplikasi kembali ke Beranda seperti sebelumnya.
Kode: `widgets/build_payment_status_page_class_info.dart` dan
`BuildPickClassPageConfirmationDialog`.

### Batalkan pendaftaran

Di Profil → Pembayaran & Kelas, setiap pendaftaran berstatus **Belum Lunas**
punya tombol merah "Batalkan pendaftaran" di bawah kotak mata kuliahnya.

```
┌──────────────────────────────────┐
│ 30 menit lalu       Belum Lunas  │
│ ┌──────────────────────────────┐ │
│ │ Basis Data        Semester 3 │ │
│ │ Kelas: bisa dipilih setelah  │ │
│ │ lunas                        │ │
│ └──────────────────────────────┘ │
│            Batalkan pendaftaran  │
└──────────────────────────────────┘
```

1. Tombol membuka konfirmasi "Batalkan Pendaftaran": "Pendaftaran Basis Data
   akan dibatalkan. Anda bisa mendaftarkannya lagi nanti." dengan tombol
   Kembali dan **Ya, batalkan** (merah).
2. Ya, batalkan → `DELETE /activation/:id`. Selama menunggu, tombol berubah
   menjadi "Membatalkan..." dan tidak bisa ditekan.
3. Berhasil: snackbar hijau "Pendaftaran Basis Data dibatalkan." dan daftar
   dimuat ulang. Mata kuliah itu bisa didaftarkan lagi dari Pendaftaran
   Praktikum.
4. Ditolak: pesan server tampil di snackbar merah, misalnya "Pendaftaran yang
   sudah lunas tidak bisa dibatalkan. Hubungi laboran bila perlu dibatalkan."
   bila laboran baru saja mengonfirmasi pembayarannya.

Pendaftaran yang sudah Lunas tidak punya tombol ini; laboran yang
membatalkannya dari web. Kode: `CancelActivationBloc` (disediakan di route
`payment-status`) dan
`widgets/build_payment_status_page_cancel_button.dart`.

### Satu HP satu akun per pertemuan

Supaya tidak ada titip akun (teman yang hadir login dengan akun mahasiswa yang
absen lalu memindai untuknya), aplikasi mengirim **kode HP** saat login dan
saat scan QR. Satu kode HP hanya bisa dipakai satu akun per pertemuan; scan
kedua dari HP yang sama untuk akun lain dibalas "HP ini sudah dipakai presensi
akun lain di pertemuan ini." dan pesan itu tampil seperti penolakan lain.

- Kode HP diambil dari paket `flutter_udid` (`lib/core/device/device_id.dart`):
  SHA-256 dari Android ID, 64 karakter. Di iPhone nanti paket yang sama
  menyimpan kodenya di Keychain. Kode ini tetap sama walaupun aplikasi dihapus
  lalu dipasang ulang, dan berubah setelah reset pabrik.
- Kode HP juga bergantung pada **kunci tanda tangan APK**. APK rilis sekarang
  ditandatangani dengan kunci debug di laptop pembuatnya
  (`~/.android/debug.keystore`), jadi selalu build dari laptop yang sama dan
  simpan cadangan file kunci itu. Kunci berbeda membuat kode HP semua
  mahasiswa berubah, dan APK baru tidak bisa dipasang di atas APK lama.
- `flutter_udid` dikunci di versi 4.0.0 karena versi 4.1 ke atas butuh Flutter
  yang lebih baru dari 3.24. Kode yang dihasilkan sama, jadi paketnya bisa
  ikut dinaikkan saat Flutter dinaikkan.
- Bila kode HP tidak terbaca, login tetap berjalan tanpa kode, sedangkan scan
  dibalas server "Perbarui aplikasi SILAB ke versi terbaru untuk melakukan
  presensi."

Status presensi mengikuti aturan yang sama dengan web: `submitted_at` kosong
berarti **belum presensi**; bila terisi, `is_attended` menentukan **hadir**
atau **tidak hadir**.

## Struktur

Clean architecture per fitur (`lib/features/<fitur>/{data,domain,presentation}`)
dengan BLoC. Semua permintaan ke backend lewat satu kelas,
`lib/core/network/api_client.dart`, yang mengurus alamat server, token,
JSON, dan pesan error. Pesan error backend diteruskan apa adanya. Gangguan
koneksi diubah menjadi pesan yang bisa dibaca: server tidak merespons dalam 20
detik, tidak dapat terhubung, dan sertifikat HTTPS server bermasalah ("Koneksi
aman ke server gagal (sertifikat HTTPS). Hubungi laboran."). Yang terakhir
dulu tidak tertangkap, jadi layar bisa tertahan di loading.

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
diputus sistem. Event `ready` setelah tersambung ulang dan event `period`
(semester baru dimulai) memuat ulang semua data sekaligus.

Setiap bloc data punya event `Refresh…` (misalnya `RefreshUserRegisteredClass`)
yang memuat ulang tanpa state loading, jadi daftar tidak berkedip. Refresh
diabaikan bila data belum pernah dibuka (state masih `Initial`), gagalnya
tidak menghapus data yang sedang tampil, dan refresh berjalan satu per satu
tanpa menumpuk (`coalesced()` di `lib/core/helpers/event_transformers.dart`):
refresh yang sama yang datang selagi satu masih berjalan digabung menjadi
satu susulan. Saat pendaftaran kelas ramai, puluhan event `class` datang
beruntun; tanpa penggabungan ini setiap HP mengirim satu permintaan per event.

Kelas asisten (Profil) hanya dimuat ulang bila event `class` menyangkut kelas
yang dipegang, atau bila daftar asisten berubah (`action: "assistants"` dari
backend). Pendaftaran mahasiswa lain di kelas yang tidak dipegang tidak memicu
permintaan apa pun.

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

- `test/core/network/api_client_test.dart` — token, body, penanganan error
  (termasuk sertifikat HTTPS bermasalah), refresh token (termasuk sesi berakhir: token dihapus, sinyal dikirim sekali),
  dan stream SSE (token, refresh, isi event, tersambung ulang,
  berhenti saat dibatalkan)
- `test/features/realtime/` — `RealtimeBloc` (koneksi pertama, tersambung
  ulang, logout), refresh diam-diam di bloc (tanpa loading, data lama tetap
  tampil bila gagal, event kelas lain diabaikan, pengumuman dihapus), dan
  `RealtimeSync` (event `period` dan `ready` setelah tersambung ulang memuat
  ulang semua tampilan, event `subject` hanya daftar mata kuliah, dan kelas
  baru ikut memuat ulang baris Kelas di Pembayaran & Kelas)
- `test/features/registration/registration_test.dart` — NIM dari email
  kampus, inisial nama, repository (token disimpan hanya bila kode benar),
  login akun belum terverifikasi membawa email, urutan state kedua bloc, form
  Daftar menolak isian kosong dan password berspasi, dan layar kode (hitung mundur, kirim otomatis)
- `test/core/helpers/event_transformers_test.dart` — refresh yang sama
  digabung jadi satu susulan, refresh berbeda tetap berurutan, dan bloc yang
  ditutup membuang antrean tanpa error
- `test/features/user_details/assisted_classes_test.dart` — kelas asisten
  dibaca dari `GET /class`, refresh diam-diam, event dari kelas yang tidak
  dipegang diabaikan, perubahan daftar asisten selalu dimuat ulang, dan bagian
  Profil hanya tampil bila memegang kelas
- `test/features/account/account_test.dart` — `PUT /auth/me` dengan token
  login, token baru disimpan hanya bila ganti password berhasil, urutan state
  kedua bloc, profil dimuat ulang diam-diam, dan validasi kedua layar (nama
  kosong/pendek, password kosong, pendek, berspasi, sama dengan yang lama,
  konfirmasi beda)
- `test/features/password_reset/password_reset_test.dart` — format email,
  repository (email belum terdaftar, akun belum diverifikasi membawa email),
  urutan state kedua bloc, simpan tidak dikirim dua kali, dan kedua layar
  (NIM dari email, validasi isian termasuk password berspasi, kode salah
  tidak menghapus password,
  hitung mundur)
- `test/features/authentication/staff_login_test.dart` — nomor 8 angka
  ditolak di form tanpa menghubungi server, role DOSEN/LABORAN dari server
  ditolak tanpa menyimpan token, dan mahasiswa tetap bisa masuk
- `test/features/authentication/login_page_test.dart` — di layar kecil
  dengan keyboard terbuka, halaman Login bisa digeser sampai Masuk dan
  Daftar tanpa meluap; tanpa keyboard isinya tetap di tengah; Enter di kolom
  password langsung login, hanya menampilkan pesan bila ada kolom kosong, dan
  tidak mengirim dua kali saat masih menunggu server
- `test/features/authentication/session_expiry_test.dart` — aplikasi yang
  dibuka setelah 15 menit tetap masuk; setelah 1 hari diarahkan ke login;
  sesi yang dicabut server saat aplikasi dipakai juga diarahkan ke login
- `test/features/classes/meetings_tab_test.dart` — tab Presensi menampilkan
  loading saat memuat, pesan dari server saat gagal, dan "Belum ada pertemuan
  di kelas ini." saat kosong; dulu ketiganya tampil kosong
- `test/features/classes/device_id_test.dart` — kode HP ikut dikirim saat
  login dan scan, login tetap berjalan bila kode tidak terbaca, pesan "HP ini
  sudah dipakai presensi akun lain di pertemuan ini." diteruskan dari server,
  dan paket kode HP yang tidak tersedia (tes di laptop) dibalas kosong
- `test/features/announcement/announcement_page_test.dart` — detail
  pengumuman sepanjang 1000 karakter bisa digulir sampai akhir di layar HP
  kecil (360×640) tanpa terpotong; sebelum 30 September 2026 halaman ini
  tidak bisa digulir, karena batas deskripsi masih 200 karakter
- `test/features/classes/registered_class_guard_test.dart` — Detail Kelas
  memakai data kelas terbaru dari `GET /class/me`, menampilkan pemberitahuan
  bila kelasnya sudah tidak ada, dan tidak salah menganggap kelas dihapus saat
  pemuatan ulang gagal
- `test/features/announcement/announcement_banner_test.dart` — kartu
  pengumuman di Beranda (layar 360×640, tinggi carousel asli): warna kartu
  dan label untuk keempat jenis serta jenis yang tidak dikenal; judul dan isi
  sangat panjang dipotong tanpa meluap dan tombol "Pelajari lebih lanjut"
  tetap di dalam kartu
- `test/features/select_subjects/cancel_activation_test.dart` — tombol
  "Batalkan pendaftaran" hanya di pendaftaran Belum Lunas; Kembali tidak
  mengirim apa pun; "Ya, batalkan" mengirim `DELETE /activation/:id`,
  menampilkan "Membatalkan..." dengan tombol nonaktif selama menunggu, lalu
  pesan server dan daftar yang diperbarui; penolakan server tampil merah dan
  tombol bisa ditekan lagi
- `test/features/select_subjects/payment_and_class_test.dart` — keempat
  keadaan baris Kelas beserta urutannya di kartu; menu Profil berisi
  "Pembayaran & Kelas" tanpa "Riwayat Pembayaran"; setelah kelas disimpan,
  aplikasi kembali ke Pembayaran & Kelas bila dibuka dari Profil dan ke
  Beranda bila dibuka dari banner, dan baris Kelas langsung berganti
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
  (`GET /class/:id/classmates`, diri sendiri ditandai "Anda"). Fitur modul
  praktikum tidak dikerjakan, jadi tab "Modul" dan widget "Segera Hadir"-nya
  sudah dihapus.
- Sengaja dibiarkan: total harga di ringkasan pendaftaran adalah tarif tetap
  Rp5.000 per mata kuliah yang ditulis di UI.
- Beberapa entity lama tidak dipakai lagi (misalnya `ClassEntity`,
  `ClassResponseEntity`, dan `RegisteredClassEntity` di `features/`).

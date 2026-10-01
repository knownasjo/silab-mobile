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
laboran menambah atau menghapusnya (event `class`). Kelas yang ia pegang juga
tampil di Jadwal dengan tanda "Asisten" (lihat "Jadwal").

## Alur yang tersambung ke web

1. Laboran membuat pengumuman bertipe **Practicum** di web → di aplikasi,
   tombol **Daftar** pada pengumuman itu membuka pendaftaran praktikum. Ini
   satu-satunya jalan ke Pendaftaran Praktikum, jadi pendaftaran "dibuka"
   laboran lewat pengumuman ini (disengaja). Pengumuman tipe lain punya tombol
   "Pelajari lebih lanjut" yang membuka halaman detail. Seluruh tombol kuning
   bisa ditekan, bukan hanya tulisannya. Warna kartu di
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

   Kartu setinggi 170 px, jadi judul dipotong setelah 2 baris dengan "…". Isi
   memakai sisa ruangnya: jumlah barisnya dihitung dari tinggi yang tersisa
   (paling banyak 3) dan baris terakhir diakhiri "…", jadi tidak ada baris
   yang terpotong setengah. Karena jarak antarbaris lega, biasanya isi dapat 1
   baris bila judulnya 2 baris dan 2 baris bila judulnya pendek. Isi lengkap ada
   di halaman detail. Pemetaannya di
   `announcement/presentation/widgets/announcement_type_style.dart`. Bila
   pengumuman yang sedang dilihat dihapus, titik penanda ikut pindah ke
   halaman yang tampil.

   Di kartu Kelas Terdaftar, nama mata kuliah dan nama dosen masing-masing
   satu baris dan dipotong "…", jadi nama dosen bergelar panjang tidak
   mendorong tombol panah keluar kartu. Bila belum punya kelas, Beranda
   menulis "Belum ada kelas. Kelas muncul di sini setelah pembayaran
   dikonfirmasi dan kelas dipilih." di atas menu bawah. Bila gagal dimuat
   (misalnya server mati), bagian pengumuman dan kelas menulis "Gagal memuat
   pengumuman." / "Gagal memuat kelas." dengan tombol "Coba lagi", dan pesan
   di bawah layar memakai pesan aslinya (misalnya "Tidak dapat terhubung ke
   server. Periksa koneksi internet.") dengan tombol "Ulangi".
2. Mahasiswa memilih mata kuliah → `POST /activation` → status "Belum Lunas"
   di Profil → Pembayaran & Kelas. Di daftar pilihan, kode mata kuliah (9 angka)
   tampil kecil di bawah nama supaya mudah dicocokkan dengan KRS. Selama masih
   Belum Lunas, pendaftaran bisa dibatalkan (lihat "Batalkan pendaftaran").

   Halaman Pendaftaran Praktikum bisa digeser, jadi tombol Selanjutnya tetap
   terjangkau walau satu semester punya banyak mata kuliah. Mata kuliah yang
   sudah didaftarkan di semester aktif tampil tercentang abu-abu dengan
   tulisan "Sudah didaftarkan" dan tidak bisa dipilih lagi; datanya dari
   `subject_id` di `GET /activation`, yang dimuat saat halaman dibuka dan ikut
   diperbarui lewat event `activation`. Bila daftar mata kuliah gagal dimuat,
   halaman menulis "Gagal memuat mata kuliah." dengan tombol "Coba lagi", bukan
   "Tidak ada praktikum yang ditawarkan". Di dialog "Simpan Pendaftaran",
   tombol Simpan berubah menjadi "Menyimpan..." dan terkunci bersama tombol
   Kembali selama menunggu, dialog tidak bisa ditutup, dan
   `AddSelectedSubjectBloc` mengabaikan tekanan kedua, jadi pendaftaran hanya
   terkirim sekali. Sebelumnya tekan ganda mengirim dua permintaan, lalu pesan
   merah "sudah pernah didaftarkan" muncul padahal pendaftaran berhasil.
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
   Simpan (lihat "Pilih Kelas" di bawah). Bila laboran membatalkan
   pembayarannya sebelum ada presensi, kelas itu hilang dari Beranda dan
   Jadwal lewat event `class` dan `activation`.
5. Kelas muncul di Beranda dan Jadwal.
6. Asisten membuka sesi presensi dan menampilkan QR di web; QR berganti setiap
   10 detik. Di Detail Kelas, pertemuan yang sesinya sedang dibuka dan belum
   dipresensi punya tombol biru "Scan QR"; mahasiswa menekannya untuk membuka
   kamera. Daftar pertemuan di sana adalah urutan dari server
   (menurut judul, Pertemuan 2 sebelum Pertemuan 10) yang dibalik, jadi nomor
   terbesar ada di atas. Ikon pertemuan lain tidak membuka kamera: bila
   presensi sudah tercatat muncul "Presensi pertemuan ini sudah tercatat.",
   bila sesinya tidak dibuka muncul "Sesi presensi sedang tidak dibuka." (dulu
   "belum dibuka oleh asisten", keliru untuk pertemuan yang sesinya sudah
   ditutup). Lihat "Detail Kelas dan Scan QR" di bawah.
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

Daftarnya berjudul "Mata Kuliah Didaftarkan" (dulu "Daftar Aktivasi").
Waktu daftar di tiap kartu memakai `formatPostedAt`
(`lib/core/helpers/time_formatter.dart`): kurang dari sehari ditulis relatif
dalam bahasa Indonesia ("5 menit yang lalu", "3 jam yang lalu"), selebihnya
"29 Sep 2026, 06.04" dalam waktu HP. Halaman detail pengumuman memakai fungsi
yang sama; dulu keduanya menulis "5 minutes ago" atau waktu mentah seperti
"2026-09-29 06:04:12.345". Selama memuat, daftar menampilkan lingkaran
berputar. Bila belum ada pendaftaran, tertulis "Belum ada pendaftaran. Daftar
praktikum lewat pengumuman Pendaftaran Praktikum di Beranda." Bila gagal
dimuat, tertulis "Gagal memuat pendaftaran." dengan tombol "Coba lagi"
(`widgets/build_status_message.dart`).

Di atas daftar ada kotak kuning "Belum dibayar: N mata kuliah" dan
"Total: Rp…" yang menghitung pendaftaran berstatus Belum Lunas dikali tarif
`practicumFeePerSubject` (Rp5.000, `lib/core/helpers/currency_formatter.dart`).
Kotak ini hilang bila semuanya sudah Lunas dan ikut berubah saat laboran
mengonfirmasi pembayaran. Tarif yang sama dipakai total di halaman Ringkasan,
yang kini tertulis "Rp10.000", bukan "Rp10000". Tarif ditulis di aplikasi,
bukan diambil dari server, jadi perubahan tarif butuh APK baru.

### Pilih Kelas

Halaman Pilih Kelas (route `pilih-kelas`) memuat `GET /class/registration`,
yang kini diurutkan server menurut nama mata kuliah lalu nama kelas (A→Z).
Selama memuat tampil lingkaran berputar; bila gagal tertulis "Gagal memuat
kelas." dengan tombol "Coba lagi"; bila kosong tertulis "Tidak ada kelas yang
bisa dipilih." Tombol Simpan hanya muncul bila ada kelas untuk dipilih.

- Mengetuk lagi kelas yang sudah dipilih (lingkaran atau barisnya)
  membatalkan pilihan. Dulu ketukan pada lingkaran memicu error dan tidak
  terjadi apa-apa.
- Bila daftar dimuat ulang (real-time atau Coba lagi) dan kelas yang dipilih
  sudah dihapus atau penuh, pilihannya dilepas, jadi Simpan tidak mengirim
  kelas yang tidak ada.
- Dialog "Simpan Pilihan Kelas" menampilkan mata kuliah dan kelas yang
  dipilih ("Kelas A · Senin, 07.00 - 08.40") dan peringatan "Kelas yang sudah
  disimpan tidak bisa diganti sendiri. Hubungi laboran jika perlu pindah."
  (hanya laboran yang bisa memindah lewat `PUT /activation/:id/class`).
- Selama menyimpan, tombol Simpan berubah menjadi "Menyimpan..." dan terkunci
  bersama Kembali, dialog tidak bisa ditutup, dan `AddSelectedClassBloc`
  mengabaikan tekanan kedua. Dulu tekan ganda mengirim dua permintaan, dan
  menutup dialog saat menyimpan bisa membuat aplikasi menutup halaman yang
  salah.
- Bila server menolak, dialog tertutup, pesan merahnya terlihat (dulu
  tertutup bayangan dialog), dan daftar kelas dimuat ulang, misalnya kelas
  yang baru penuh menjadi abu-abu.
- Dialog "Berhasil" tidak tertutup oleh ketukan di luar; tombol kembali HP
  bekerja sama dengan OK (memuat ulang data lalu kembali ke halaman asal).

Halaman Pilih Kelas, Pendaftaran Praktikum, dan Pembayaran & Kelas diberi
ruang kosong setinggi `bottomNavbarSpace` (100,
`lib/core/common/widgets/custom_bottom_navbar.dart`) di bawah isinya, jadi
tombol terakhir selalu berhenti di atas menu bawah. Dulu di layar 360×640
tombol Simpan tertutup menu bawah bila satu mata kuliah punya 5 kelas, begitu
juga Selanjutnya (4–5 mata kuliah) dan Pilih Kelas di Pembayaran & Kelas (3
mata kuliah atau lebih).

### Batalkan pendaftaran

Di Profil → Pembayaran & Kelas, setiap pendaftaran berstatus **Belum Lunas**
punya tombol merah "Batalkan pendaftaran" di bawah kotak mata kuliahnya.

```
┌──────────────────────────────────┐
│ 30 menit yang lalu  Belum Lunas  │
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

### Jadwal

`ScheduleApiService` menyusun Jadwal dari `GET /class/me` (kelas yang diikuti)
dan `GET /class` (kelas yang dipegang sebagai asisten), dikelompokkan per hari
(Senin → Minggu) dan diurutkan menurut jam dalam satu hari.

- Tiap kartu menampilkan ruang di belakang jam ("07.00 - 08.40 · PSI"). Ruang
  dibaca dari field `room` yang sudah dikirim backend (`ClassEntity.room`);
  kartu Detail Kelas juga mendapat kolom **Ruang** di samping Hari dan Sesi.
- Kartu kelas yang diikuti bisa diketuk (ikon panah) dan membuka Detail Kelas
  dengan `pushNamed`, jadi tombol kembali kembali ke Jadwal.
- Kelas asisten bertanda "Asisten" dan tidak bisa diketuk, karena asisten
  tidak scan presensi di kelas itu. Jadwal dimuat ulang saat event `class`
  dengan `action: "assistants"` datang, atau saat event `class` menyangkut
  kelas yang sedang tampil di Jadwal (misalnya nama mata kuliah diubah).
- Di bawah daftar ada ruang `bottomNavbarSpace`; dulu di layar 360×640 kartu
  terakhir tertutup menu bawah bila kelas tersebar di 4 hari atau lebih.
- Bila gagal dimuat tertulis "Gagal memuat jadwal." dengan tombol "Coba lagi"
  (dulu "Terjadi suatu kesalahan, coba lagi!" dengan tombol ikon saja).

### Detail Kelas dan Scan QR

- Seluruh halaman Detail Kelas yang digeser, dan di bawahnya ada ruang
  `bottomNavbarSpace` supaya pertemuan terakhir bisa sampai di atas menu
  bawah. Dulu tab Presensi/Classmates berada di kotak setinggi lebar layar
  dengan geseran sendiri: di HP 360×640 hanya 4 pertemuan terlihat dan bagian
  bawah kotak tertutup menu, di HP 411×891 hanya 5 pertemuan sementara layar
  di bawahnya kosong.
- Kartu kelas (Detail Kelas dan Beranda) memakai tinggi minimal 120, jadi
  memanjang bila ukuran huruf HP diperbesar (dulu terpotong di 1,3×). Nama
  dosen dan judul pertemuan yang panjang (server membolehkan 50 huruf)
  dipotong "…" dalam satu baris.
- Bila tab Presensi atau Classmates gagal dimuat, pesannya disertai tombol
  "Coba lagi".
- Halaman scan: dialog memuat setelah QR terbaca tidak bisa ditutup dengan
  ketukan di luar atau tombol kembali HP, jadi setelah presensi tercatat
  aplikasi selalu kembali ke Detail Kelas. Dulu dialog itu bisa tertutup, lalu
  aplikasi menutup halaman scan sekaligus Detail Kelas dan mahasiswa sampai di
  Beranda.
- Bila izin kamera ditolak, tampil "Izin kamera ditolak. Izinkan Kamera untuk
  SILAB di Pengaturan HP, lalu tekan Coba lagi." dengan tombol "Coba lagi"
  yang menyalakan kamera lagi (galat kamera lain: "Kamera tidak bisa dibuka.
  Tekan Coba lagi."). Dulu tampil layar hitam "Camera permission denied.".
  Bingkai kuning disembunyikan selama kamera bermasalah.
- Tombol kembali di halaman scan dipindah ke kiri atas; di HP 360×640 dulu
  tombol itu menimpa sudut kiri bawah bingkai.

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
  ulang semua tampilan, event `subject` hanya daftar mata kuliah, kelas
  baru ikut memuat ulang baris Kelas di Pembayaran & Kelas, dan pergantian
  asisten atau perubahan kelas yang tampil di Jadwal memuat ulang Jadwal)
- `test/features/schedule/schedule_page_test.dart` — kelas di 4–6 hari pada
  layar 360×640: kartu terakhir bisa digeser sampai di atas menu bawah; server
  mati menampilkan "Gagal memuat jadwal." dan Coba lagi memuat ulang; kartu
  menampilkan ruang dan bila diketuk membuka Detail Kelas berkolom Ruang, lalu
  kembali ke Jadwal; kelas asisten bertanda "Asisten", urut jam bersama kelas
  lain, dan tidak bisa diketuk
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
- `test/features/classes/class_detail_test.dart` — 14 pertemuan di HP
  360×640 digeser bersama halaman sampai di atas menu bawah dan mengisi layar
  HP 411×891 (minimal 7 baris); nama dosen panjang dan huruf HP 1,3× tidak
  merusak kartu; judul pertemuan 50 huruf dipotong; tombol "Scan QR" hanya di
  pertemuan terbuka yang belum dipresensi dan membuka kamera; pesan "Sesi
  presensi sedang tidak dibuka."; Coba lagi di kedua tab; saat presensi
  dicatat, ketukan di luar dan tombol kembali HP diabaikan lalu aplikasi
  kembali ke Detail Kelas; izin kamera ditolak tampil berbahasa Indonesia dan
  Coba lagi menyalakan kamera; tombol kembali scan tidak menimpa bingkai.
  Kamera ditiru lewat `MethodChannel` paket `mobile_scanner`.
- `test/features/classes/registered_class_guard_test.dart` — Detail Kelas
  memakai data kelas terbaru dari `GET /class/me`, menampilkan pemberitahuan
  bila kelasnya sudah tidak ada, dan tidak salah menganggap kelas dihapus saat
  pemuatan ulang gagal
- `test/features/announcement/announcement_banner_test.dart` — kartu
  pengumuman di Beranda (layar 360×640 dan 393×851, tinggi carousel asli):
  warna kartu, label, dan tombol ("Daftar" untuk Pendaftaran Praktikum,
  "Pelajari lebih lanjut" untuk lainnya) untuk keempat jenis serta jenis yang
  tidak dikenal; judul panjang dipotong 2 baris dan isi berhenti di baris utuh
  terakhir tanpa terpotong setengah; judul pendek memberi isi lebih banyak
  baris; tepi tombol kuning ikut membuka halaman tujuan
- `test/features/home/beranda_test.dart` — memakai huruf Roboto dari Flutter
  (`test/helpers/real_font.dart`, lebarnya hampir sama dengan Manrope) supaya
  letak teks sama dengan di HP: nama dosen bergelar panjang dipotong "…"
  tanpa meluap; dengan huruf HP 1,3× kartu kelas memanjang tanpa terpotong;
  server mati menampilkan pesan asli tanpa bahasa Inggris dan
  tombol "Coba lagi" yang terlihat di atas menu bawah dan bisa memuat ulang;
  data akun gagal dimuat menampilkan "Ulangi"; pesan belum punya kelas terbaca
  utuh di layar 360×640; titik penanda pengumuman pindah setelah pengumuman
  yang dilihat dihapus
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
  Beranda bila dibuka dari banner, dan baris Kelas langsung berganti; judul
  "Mata Kuliah Didaftarkan" dan waktu berbahasa Indonesia; keterangan belum
  ada pendaftaran; server mati menampilkan "Gagal memuat pendaftaran." dan
  Coba lagi memuat ulang; lingkaran berputar selama memuat; kotak Belum
  dibayar menghitung jumlah dan total mata kuliah Belum Lunas di atas daftar
  dan hilang bila semua Lunas
- `test/core/helpers/currency_formatter_test.dart` — rupiah dengan titik
  ribuan tanpa desimal
- `test/core/helpers/time_formatter_test.dart` — waktu relatif berbahasa
  Indonesia untuk kurang dari sehari, tanggal dengan bulan singkat Indonesia
  (Mei, Agu, Des) dan jam untuk yang lebih lama, waktu UTC dari server
  diubah ke waktu HP, dan isian kosong atau rusak menjadi "-"
- `test/features/select_subjects/daftar_praktikum_test.dart` — 9 mata
  kuliah di layar 360×640: halaman bisa digeser jari sampai Selanjutnya;
  server mati menampilkan "Gagal memuat mata kuliah." dan Coba lagi memuat
  ulang; mata kuliah yang sudah didaftarkan tercentang, terkunci, dan
  bertanda; Simpan yang ditekan berkali-kali (juga Kembali dan ketukan di luar
  dialog) hanya mengirim satu `POST /activation` lalu membuka Pembayaran
  tanpa pesan merah; penolakan server menutup dialog dan tetap di Ringkasan
- `test/features/select_subjects/pilih_kelas_test.dart` — dialog konfirmasi
  menampilkan kelas yang dipilih dan peringatan; Simpan yang ditekan
  berkali-kali (juga Kembali, ketukan di luar, dan tombol kembali HP) hanya
  mengirim satu `POST /class/registration`; dialog Berhasil tidak tertutup
  ketukan di luar dan tombol kembali HP sama dengan OK; penolakan server
  menutup dialog, menampilkan pesan, dan memuat ulang daftar; pilihan yang
  kelasnya dihapus atau penuh dilepas; ketuk lagi membatalkan pilihan;
  lingkaran memuat, "Gagal memuat kelas." dengan Coba lagi, dan keterangan
  bila kosong
- `test/features/select_subjects/bottom_navbar_space_test.dart` — di layar
  360×640 dengan menu bawah tampil, tombol Simpan (3–6 kelas), Selanjutnya
  (3–6 mata kuliah), dan Pilih Kelas (2–4 pendaftaran) bisa digeser sampai di
  atas menu bawah (`test/helpers/small_phone_shell.dart`)
- `test/features/backend_contract_test.dart` — setiap entity membaca contoh
  respons asli backend; Jadwal disusun dari contoh `GET /class/me` dan
  `GET /class` (urut hari dan jam, ruang ikut, kelas asisten bertanda)
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
- Sengaja dibiarkan: tarif praktikum adalah angka tetap Rp5.000 per mata
  kuliah di aplikasi (`practicumFeePerSubject`), dipakai di Ringkasan dan
  kotak Belum dibayar.
- Beberapa entity lama tidak dipakai lagi (misalnya `ClassEntity`,
  `ClassResponseEntity`, dan `RegisteredClassEntity` di `features/`).

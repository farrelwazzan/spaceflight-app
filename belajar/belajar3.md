Betul. Kalau teknis responsi mengharuskan kamu menggunakan project yang sudah dibuat sebelumnya, strategi terbaik adalah **mengambil project dari GitHub ke PC praktikum, menjalankannya, memastikan semua fitur berfungsi, lalu mengerjakan soal tambahan.**

Kita susun alur dari awal sampai siap mengerjakan soal. Aku juga akan membedakan perintah Git dan Flutter agar kamu tidak tertukar.

# **Panduan persiapan responsi Flutter**

## **1. Persiapan sebelum hari responsi**

Pastikan beberapa hal berikut sudah siap:

- Akun GitHub bisa diakses.
- Repository `spaceflight-app` sudah tersedia.
- Git sudah terinstal di PC praktikum.
- Flutter SDK sudah terinstal.
- VS Code dan extension Flutter/Dart sudah tersedia.
- HP Android atau emulator siap digunakan.

Repository yang akan digunakan:

[GitHub — spaceflight-app](https://github.com/farrelwazzan/spaceflight-app?utm_source=chatgpt.com)

Sebaiknya pastikan juga kamu ingat akun GitHub dan bisa melakukan autentikasi Git dari PC praktikum.

## **2. Alur utama saat mulai responsi**

1. **Clone repository dari GitHub**

   Mengambil seluruh project ke PC praktikum.
2. **Masuk ke folder project**

   Membuka folder project yang baru diunduh.
3. **Install dependency**

   Mengunduh package yang dibutuhkan aplikasi.
4. **Periksa perangkat**

   Memastikan HP atau emulator terdeteksi.
5. **Jalankan aplikasi**

   Memastikan project dapat berjalan sebelum dimodifikasi.
6. **Kerjakan soal tambahan**

   Mulai mengubah kode sesuai instruksi soal.
7. **Uji dan simpan hasil**

   Pastikan perubahan berhasil dan simpan pekerjaan.

## **3. Perintah yang perlu kamu jalankan**

Misalnya kamu ingin menyimpan project di folder `D:\Responsi`.

**Langkah 1 — Buka terminal di lokasi penyimpanan**

```
cd D:\Responsi
```

**Langkah 2 — Ambil project dari GitHub**

Gunakan:

```
git clone https://github.com/farrelwazzan/spaceflight-app.git
```

Perintah `git clone` akan menyalin seluruh repository, termasuk kode dan riwayat Git, ke komputer.

Hasilnya akan menjadi:

```
D:\Responsi\
└── spaceflight-app\
    ├── android\
    ├── lib\
    ├── ios\
    ├── pubspec.yaml
    ├── pubspec.lock
    └── ...
```

**Langkah 3 — Masuk ke folder project**

```
cd spaceflight-app
```

**Langkah 4 — Buka project di VS Code**

```
code .
```

Titik (`.`) berarti membuka folder yang sedang aktif.

**Langkah 5 — Ambil seluruh dependency Flutter**

```
flutter pub get
```

Ini langkah penting.

`flutter pub get` membaca `pubspec.yaml` dan `pubspec.lock`, kemudian mengambil package yang dibutuhkan, seperti:

- `http`
- `shared_preferences`
- `url_launcher`

Kamu tidak perlu menjalankan `flutter pub add` lagi karena dependency sudah tercatat di project.

**Langkah 6 — Periksa instalasi Flutter**

```
flutter doctor
```

Pastikan tidak ada masalah yang menghalangi proses menjalankan aplikasi.

**Langkah 7 — Periksa perangkat**

```
flutter devices
```

Jika HP sudah terhubung melalui USB Debugging, seharusnya perangkat Android muncul.

**Langkah 8 — Jalankan aplikasi**

```
flutter run
```

Jika ada beberapa perangkat, kamu bisa memilih perangkat tertentu:

```
flutter run -d ID_PERANGKAT
```

Siap mengerjakan responsi

Jika aplikasi berhasil berjalan, kamu sudah bisa mulai mengerjakan soal tambahan.

## **4. Setelah soal tambahan diberikan**

Misalnya soal meminta menambahkan fitur pencarian berita.

Alurnya:

1. Buka `lib/pages/list_page.dart`.
2. Pelajari kode yang sudah tersedia.
3. Ubah kode sesuai ketentuan soal.
4. Simpan perubahan (`Ctrl + S`).
5. Lihat hasilnya di HP atau emulator.
6. Perbaiki jika masih ada kesalahan.

Saat aplikasi sedang berjalan, kamu bisa memanfaatkan **Hot Reload** untuk melihat perubahan kode tanpa memulai ulang aplikasi.

Namun, jika ada perubahan dependency atau konfigurasi native Android, lakukan stop dan jalankan kembali aplikasi.

## **5. Perintah Git dan Flutter yang wajib dibedakan**

Ini ringkasan yang sebaiknya kamu hafalkan.

| Perintah                       | Fungsi                                           |
| ------------------------------ | ------------------------------------------------ |
| `git clone URL`                | Mengambil project dari GitHub untuk pertama kali |
| `git pull`                     | Mengambil pembaruan dari GitHub                  |
| `git status`                   | Memeriksa perubahan file                         |
| `git add .`                    | Menyiapkan perubahan untuk commit                |
| `git commit -m "pesan"`        | Menyimpan perubahan ke riwayat Git               |
| `git push`                     | Mengirim commit ke GitHub                        |
| `flutter pub get`              | Mengambil dependency project                     |
| `flutter doctor`               | Memeriksa instalasi Flutter                      |
| `flutter devices`              | Melihat perangkat yang terhubung                 |
| `flutter run`                  | Menjalankan aplikasi                             |
| `flutter clean`                | Membersihkan hasil build sementara               |
| `flutter pub add nama_package` | Menambahkan dependency baru                      |

## **6. Kalau project sudah pernah diambil sebelumnya**

Ini juga penting. Jangan menjalankan `git clone` berulang kali di folder yang sama.

Kalau project sudah ada di PC dan kamu ingin mengambil pembaruan terbaru dari GitHub, gunakan:

```
git pull origin main
```

Kemudian:

```
flutter pub get
flutter run
```

## **7. Checklist praktis saat responsi**

Ini urutan singkat yang bisa kamu jadikan catatan.

**Checklist persiapan**

0/10 selesai

Buka terminal di folder penyimpanan project

Jalankan git clone repository

Masuk ke folder spaceflight-app

Buka VS Code dengan code .

Jalankan flutter pub get

Periksa dengan flutter doctor

Hubungkan HP dan aktifkan USB Debugging

Periksa dengan flutter devices

Jalankan flutter run

Pastikan aplikasi berjalan sebelum mengerjakan soal

Reset checklist

## **Catatan penting dariku**

Ada tiga hal yang menurutku paling perlu kamu ingat:

1. `git clone` hanya untuk mengambil project pertama kali ke PC.
2. `flutter pub get` dilakukan setelah clone agar seluruh dependency terpasang.
3. `flutter run` untuk memastikan aplikasi berjalan sebelum kamu mulai mengubah kode.

Jangan langsung mengerjakan soal begitu project berhasil di-clone. Sisihkan beberapa menit untuk memastikan aplikasi awal bisa berjalan. Dengan begitu, kalau ada error setelah kamu mengubah kode, kamu bisa lebih mudah mengetahui sumber masalahnya.

**Saran terakhir:** sebelum hari responsi, cobalah simulasi proses ini sekali di PC lain atau folder baru pada PC-mu. Dengan begitu, kamu tidak hanya hafal perintahnya, tetapi sudah pernah mempraktikkan alurnya.
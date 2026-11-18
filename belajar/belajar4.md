Ada. Menurutku, ada dua hal yang perlu kamu persiapkan: **strategi mengerjakan soal agar tidak kehabisan waktu** dan **memastikan project bisa berjalan di emulator meskipun sebelumnya dikembangkan menggunakan HP Android fisik.**

Kita bahas satu per satu.

# **1. Prioritas saat mengerjakan responsi**

Jangan langsung mengubah kode begitu membaca soal. Biasakan memahami soal dan mencari file yang berkaitan terlebih dahulu.

Aku menyarankan urutan prioritas berikut.

| Prioritas | Hal yang dilakukan                | Tujuan                                           |
| --------- | --------------------------------- | ------------------------------------------------ |
| 1         | Baca seluruh soal                 | Memahami semua permintaan                        |
| 2         | Tandai fitur yang diminta         | Menentukan bagian yang perlu diubah              |
| 3         | Cari file terkait                 | Menghindari perubahan file yang tidak diperlukan |
| 4         | Kerjakan fitur utama              | Memenuhi inti soal                               |
| 5         | Jalankan dan uji aplikasi         | Memastikan fitur bekerja                         |
| 6         | Perbaiki tampilan jika diperlukan | Menyesuaikan hasil dengan ketentuan              |

**Prinsip penting: utamakan fungsi daripada tampilan.**

Misalnya soal meminta pencarian berita:

- Pastikan pencarian benar-benar berfungsi.
- Pastikan filter author tetap berjalan.
- Pastikan pesan ketika hasil tidak ditemukan muncul.
- Baru perhatikan ukuran dan posisi TextField.

Jangan menghabiskan waktu mempercantik tampilan jika fungsi utama belum selesai.

# **2. Kenali file yang paling sering diubah**

Untuk project Spaceflight News, prioritaskan memahami lima kelompok file ini.

| Kebutuhan soal             | File                     |
| -------------------------- | ------------------------ |
| Tampilan daftar dan filter | `list_page.dart`         |
| Tampilan detail berita     | `detail_page.dart`       |
| Penyimpanan Favourite      | `favourite_service.dart` |
| Tampilan Favourite         | `favourite_page.dart`    |
| Navigasi dan menu          | `home_page.dart`         |

Kemudian pahami tiga file pendukung:

- `spaceflight.dart` untuk struktur data.
- `spaceflight_service.dart` untuk mengambil data API.
- `auth_service.dart` untuk login dan register.

Dengan memahami file-file tersebut, kamu sudah mempunyai gambaran sebagian besar aplikasi.

# **3. Bagaimana jika di laboratorium menggunakan emulator?**

Tidak perlu membuat project baru

Kabar baiknya, project Flutter yang sebelumnya kamu jalankan di HP Redmi Note 13 tetap bisa dijalankan di emulator.

Flutter mendukung banyak target perangkat. Kode Dart dan sebagian besar struktur aplikasinya tetap sama.

[How to Remotely Restart Android Phones Without Root | Localtonet Blog](https://images.openai.com/static-rsc-4/GW9waddQAqijDswWMV3Dz_LAwqpaH-LaSbIUWcng2iLjTAoVIZuwhawM3VtdPJ6-bJoJQPjElCImcpyWweR4zibVw6zV1fOTdUokMwTRBqxG6ODnDTZugt1cjef-6H0ivixH4miVikwp9zqRQOR1hBDAwtJR4rF7__UKQXe2kvw?purpose=inline)

**HP Android**

Perangkat fisik yang sebelumnya kamu gunakan.

[Run your first app on the Android Emulator  |  Android Developers](https://images.openai.com/static-rsc-4/lPDicrSTS34DBfYiqhw_V8KDVclmGY0T4ijEzYamwj7ZZWnW-5YURVM1ZmlU1pCZHK1d0XizAWrwpXwGgFR6f-CUBRD_hWqGvnutPgmTiiA3JZiTJFK5G77PliIOgyQvOvHdZ6d_cOKkhgUFB6ktvY3cvlmTQSbMwR7-nUwIjDo?purpose=inline)

**Android Emulator**

Perangkat virtual yang mungkin digunakan di lab.

## **Penyesuaian yang perlu dilakukan**

**A. Pastikan Android Emulator sudah tersedia**

Di komputer laboratorium, buka Android Studio:

1. Pilih Device Manager.
2. Periksa apakah sudah ada virtual device.
3. Jika belum ada, buat virtual device, misalnya Pixel.
4. Pilih system image Android yang tersedia.
5. Jalankan emulator.

Jika lab sudah menyediakan emulator, kamu tidak perlu membuatnya lagi.

**B. Periksa apakah emulator terdeteksi Flutter**

Buka terminal VS Code:

```
flutter devices
```

Contoh hasil yang mungkin muncul:

```
2 connected devices:

sdk gphone64 x86 64 (mobile)
Chrome (web)
```

Nama emulator bisa berbeda tergantung konfigurasi lab.

**C. Jalankan aplikasi pada emulator**

```
flutter run
```

Jika ada beberapa perangkat dan ingin memilih emulator secara khusus:

```
flutter run -d emulator-5554
```

Gunakan ID perangkat yang benar-benar muncul dari `flutter devices`, jangan langsung mengasumsikan ID-nya.

## **Apakah kode perlu diubah?**

Untuk project kita, secara umum tidak perlu.

| Bagian aplikasi      | Penyesuaian                            |
| -------------------- | -------------------------------------- |
| Login dan Register   | Tidak perlu                            |
| API Spaceflight News | Tidak perlu                            |
| List berita          | Tidak perlu                            |
| Filter author        | Tidak perlu                            |
| Favourite            | Tidak perlu                            |
| URL Launcher         | Tidak perlu perubahan kode             |
| Tampilan             | Mungkin perlu penyesuaian ukuran layar |

Ada satu hal yang perlu diperhatikan: `url_launcher` pada emulator akan membuka browser atau aplikasi yang tersedia di emulator. Jadi pastikan emulator memiliki browser yang dapat digunakan.

# **4. Perhatikan perbedaan emulator dan HP fisik**

Ada beberapa perbedaan yang bisa memengaruhi pengerjaan.

| Aspek        | HP fisik             | Emulator                  |
| ------------ | -------------------- | ------------------------- |
| Kecepatan    | Bergantung HP        | Bergantung spesifikasi PC |
| Internet     | Wi-Fi/data HP        | Koneksi internet PC       |
| Browser      | Browser HP           | Browser emulator          |
| Ukuran layar | Layar HP sebenarnya  | Ukuran virtual            |
| Performa     | Bergantung perangkat | Bisa lebih berat untuk PC |

**Khusus untuk emulator:** jangan menunggu sampai hari responsi untuk mencoba menjalankannya. Pastikan Android SDK, emulator, dan system image sudah terpasang sebelum hari ujian.

# **5. Persiapan yang paling aku prioritaskan**

Kalau aku berada di posisimu, aku akan membagi waktu persiapan seperti ini:

**Prioritas belajar**

**Memahami kode project**

## **40%**

Pahami alur API, model, ListPage, DetailPage, dan Favourite.

**Latihan modifikasi fitur**

## **35%**

Pencarian, sorting, filter, dan fitur tambahan.

**Persiapan lingkungan**

## **15%**

Git clone, pub get, emulator, dan menjalankan aplikasi.

**Simulasi waktu ujian**

## **10%**

Mengerjakan soal dengan batas waktu.

Ini pembagian waktu belajar yang disarankan, bukan ketentuan ujian.

## **6. Satu hal yang jangan sampai terlupakan**

Sebelumnya kita pernah menemukan masalah Kotlin incremental ketika project berada di drive D: dan pub cache berada di C:. Kita menyelesaikannya dengan pengaturan:

```
kotlin.incremental=false
```

di `android/gradle.properties`.

Pastikan file tersebut sudah ikut tersimpan di GitHub. Dari commit sebelumnya, `android/gradle.properties` memang ikut terunggah, tetapi untuk berjaga-jaga kamu bisa memeriksanya di repository.

Kalau PC laboratorium memiliki konfigurasi berbeda, belum tentu pengaturan tersebut dibutuhkan. Jangan mengubah konfigurasi Gradle tanpa alasan jika project sudah berhasil dibangun.

## **Rekomendasi langkah berikutnya**

Menurutku, ada satu latihan persiapan yang sangat penting sebelum melanjutkan soal pencarian:

**Coba jalankan project Spaceflight News dari GitHub menggunakan Android Emulator, bukan HP fisik.**

Dengan begitu, kamu sudah mensimulasikan kondisi laboratorium sekaligus menguji apakah project hasil clone benar-benar siap digunakan.

Kalau berhasil, kita bisa melanjutkan simulasi soal tambahan tanpa perlu khawatir lagi soal lingkungan pengembangan.
Jika sebuah halaman detail yang tadinya hanya berfungsi untuk menampilkan informasi (*Read-Only*) ingin diubah agar pengguna bisa **mengedit atau mengubah informasinya** (seperti mengubah judul artikel), maka ada beberapa perubahan besar yang harus kamu lakukan.

Perubahan paling utamanya terletak pada penggantian komponen tampilan: **dari yang tadinya hanya menggunakan `Text` biasa, harus diubah menjadi `TextField` atau `TextFormField`.**

---

### 3 Perubahan Utama yang Harus Dilakukan:

#### 1. Mengubah Variabel `item` menjadi Bisa Diubah (`mutable`)

Biasanya di halaman Detail, objek `item` dideklarasikan dengan `final` (artinya tidak bisa diubah). Karena sekarang data bisa diedit, kita perlu membuat variabel penampung baru atau mengizinkan nilainya diperbarui.

#### 2. Menggunakan `TextEditingController` untuk Setiap Bagian yang Ingin Diedit

Sama seperti saat membuat halaman *Login* atau *Register*, setiap kolom input membutuhkan *controller* supaya teks yang diketik pengguna bisa diambil nilainya.

* Jika ingin mengubah **Judul**, kamu butuh:
```dart
final titleController = TextEditingController();

```


* Saat halaman pertama kali dibuka (`initState`), masukkan judul lama ke dalam *controller* tersebut:
```dart
@override
void initState() {
  super.initState();
  titleController.text = widget.item.title; // Mengisi teks awal dengan judul artikel saat ini
  checkFavourite();
}

```


* Jangan lupa bersihkan di `dispose()`:
```dart
@override
void dispose() {
  titleController.dispose();
  super.dispose();
}

```



#### 3. Mengubah `Text` Menjadi `TextField` di Bagian UI (`build`)

Di sinilah perubahan visual yang paling terasa. Kamu harus mengganti widget `Text` biasa dengan `TextField`.

**Sebelumnya (Hanya menampilkan teks statis):**

```dart
// Judul artikel
Text(
  widget.item.title,
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

```

**Sesudah (Berubah menjadi kotak input yang bisa diedit pengguna):**

```dart
// Judul artikel sekarang bisa diketik dan diubah
TextField(
  controller: titleController, // Hubungkan dengan controller judul
  maxLines: null, // Biar bisa melebar ke bawah jika judulnya panjang
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
  decoration: const InputDecoration(
    labelText: 'Edit Judul Artikel',
    border: OutlineInputBorder(), // Membentuk kotak input yang rapi
  ),
),

```

---

### 4. Menambahkan Tombol "Simpan Perubahan" (Save)

Karena sekarang pengguna bisa mengetik perubahan, kamu butuh tombol untuk menyimpan data baru tersebut.

Biasanya, kamu bisa menaruh tombol **Save** di dalam `actions:` pada `AppBar` di pojok kanan atas, atau membuat tombol besar di bagian bawah halaman:

```dart
// Contoh fungsi untuk menyimpan perubahan
void saveChanges() {
  String updatedTitle = titleController.text;

  // Lakukan logika penyimpanan, misalnya memperbarui data ke database lokal, 
  // API, atau dikembalikan ke halaman sebelumnya (callback).
  
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Perubahan berhasil disimpan!')),
  );
}

```

---

### Rangkuman Pola Transformasi Tampilan:

* **Menampilkan Data (Read-Only):** Menggunakan widget **`Text(...)`**. Pengguna hanya bisa membaca.
* **Mengubah Data (Editable):** Menggunakan widget **`TextField(...)`** atau **`TextFormField(...)`** yang dihubungkan dengan **`TextEditingController`**. Pengguna bisa mengetik dan menghapus teks layaknya form pendaftaran atau catatan.
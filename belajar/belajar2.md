Untuk menambahkan fitur pencarian (*search*) berdasarkan judul artikel, alurnya hampir mirip dengan form login, tetapi ditambah sedikit logika pemfilteran data.

Kita **tidak menggunakan perulangan manual** (`for` atau `while`), melainkan memanfaatkan fungsi bawaan Dart/Flutter bernama **`.where()`** yang dipadukan dengan **`setState()`**.

Berikut adalah 3 langkah utama yang harus kamu lakukan pada file `ListPage` di atas:

---

### Langkah 1: Tambahkan Controller dan Variabel Penyimpan Kata Kunci

Pertama, siapkan *controller* untuk kotak input pencarian dan sebuah variabel untuk menampung teks yang sedang diketik pengguna.

Di dalam kelas `_ListPageState`, tambahkan ini:

```dart
class _ListPageState extends State<ListPage> {
  final SpaceflightService service = SpaceflightService();
  late Future<List<Spaceflight>> futureData;

  String? selectedAuthor;
  
  // --- TAMBAHAN BARU UNTUK SEARCH ---
  final searchController = TextEditingController();
  String searchQuery = ''; // Menyimpan kata kunci yang sedang diketik

```

Jangan lupa bersihkan *controller*-nya di fungsi `dispose()`:

```dart
  @override
  void dispose() {
    searchController.dispose(); // --- TAMBAHAN BARU ---
    super.dispose();
  }

```

---

### Langkah 2: Tambahkan Kotak Input (`TextField`) di UI

Letakkan widget `TextField` di atas daftar chip filter atau di dalam `Column` utama, agar kotak pencarian muncul di layar.

```dart
          return Column(
            children: [
              // --- TAMBAHAN BARU: KOTAK PENCARIAN (SEARCH BAR) ---
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Cari judul berita...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Tombol 'X' untuk menghapus teks pencarian dengan cepat
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                  // Setiap kali huruf diketik, jalankan setState untuk memperbarui tampilan
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase(); // Ubah ke huruf kecil agar pencarian tidak case-sensitive (huruf besar/kecil tetap terbaca)
                    });
                  },
                ),
              ),

              // Daftar chip filter (kode lama tetap di sini)
              SingleChildScrollView(...),
              
              // Daftar artikel...

```

---

### Langkah 3: Update Logika Pemfilteran Data (`filteredData`)

Sebelumnya, kode kamu hanya memfilter berdasarkan `author`. Sekarang, kita **gabungkan** filter *author* DAN filter *pencarian judul* menjadi satu.

Ganti bagian pemfilteran data yang lama dengan kode ini:

```dart
          // 1. Ambil daftar author unik (kode lama)
          List<String> authors = data
              .map((item) => item.author)
              .toSet()
              .toList();

          // 2. --- MODIFIKASI FILTER: GABUNGKAN AUTHOR & PENCARIAN JUDUL ---
          List<Spaceflight> filteredData = data.where((item) {
            // Cek apakah cocok dengan Author yang dipilih (jika ada)
            bool matchesAuthor = selectedAuthor == null || item.author == selectedAuthor;

            // Cek apakah judul artikel mengandung kata kunci yang diketik user
            bool matchesSearch = item.title.toLowerCase().contains(searchQuery);

            // Artikel hanya akan dimunculkan jika lolos kedua filter tersebut
            return matchesAuthor && matchesSearch;
          }).toList();

```

---

### Bagaimana Cara Kerjanya? (`onChanged` & `.where()`)

1. **`onChanged: (value) { setState(() { searchQuery = value.toLowerCase(); }); }`**
* Setiap kali pengguna mengetik satu huruf di `TextField`, fungsi `onChanged` mendeteksinya secara *real-time*.
* `setState` dipanggil agar Flutter merender ulang (refresh) halaman.


2. **`.where(...)`**
* Ini adalah fungsi bawaan list di Dart (bukan perulangan manual). Fungsinya menyaring isi daftar (`data`).
* Di dalam `.where`, kita mencocokkan dua hal: Apakah *author*-nya sesuai? Dan apakah `item.title` (judul berita) **mengandung** kata yang diketik di `searchQuery` (`item.title.toLowerCase().contains(searchQuery)`)?
* Jika ya, artikel tersebut dimasukkan ke `filteredData` dan langsung tampil di `ListView.builder`.
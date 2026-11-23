### Tugas 7

1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

= Widget tree adalah susunan widget yang membentuk tampilan aplikasi. Widget induk mengatur widget anaknya. Di proyek ini `MyApp` memuat `MaterialApp`, lalu halaman `MyHomePage`.


2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

= `MaterialApp` mengatur tema dan halaman awal, `Scaffold` membentuk kerangka halaman, `AppBar` menampilkan judul, `Text` menampilkan tulisan, `Padding` dan `SizedBox` memberi jarak, `Column` dan `Row` menyusun widget, `Center` memusatkan konten, `Card` dan `Container` membentuk wadah, `GridView.count` membuat kisi menu, `Material` dan `InkWell` membuat kartu menu yang bisa ditekan, `Icon` menampilkan ikon, dan `SnackBar` menampilkan pesan. `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` adalah widget buatan proyek. `ItemHomepage` menyimpan data menu, tetapi bukan widget.


3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

= `MaterialApp` menjadi wadah utama aplikasi bergaya Material. Di proyek ini, widget tersebut mengatur tema, judul, dan halaman awal (`MyHomePage`), serta menyediakan akses ke tema melalui `BuildContext`.


4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

= `StatelessWidget` cocok untuk tampilan yang tidak mengubah state sendiri, sedangkan `StatefulWidget` dipakai jika data tampilan dapat berubah. Widget halaman dan kartu di proyek ini menggunakan `StatelessWidget`, dan ketukan menu hanya menampilkan `SnackBar`.


5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

= `BuildContext` menunjukkan posisi widget di dalam widget tree dan membantu mengambil layanan dari widget di atasnya. Di proyek ini, `context` dipakai untuk mengambil warna tema, ukuran layar, dan menampilkan `SnackBar`.


6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

= Hot reload menerapkan perubahan kode tanpa menghapus state aplikasi. Hot restart menjalankan ulang aplikasi dan menginisialisasi state dari awal. Perubahan kode native atau konfigurasi plugin biasanya memerlukan full restart agar aplikasi dibangun dan dijalankan ulang.



### Tugas 8
1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

= `Navigator.push()` menambahkan halaman baru ke atas stack sehingga halaman sebelumnya masih bisa dibuka kembali dengan tombol Back. `Navigator.pushReplacement()` mengganti halaman aktif dengan halaman baru, sedangkan `Navigator.pop()` menutup halaman teratas. Kartu aksi Add Education membuka `EducationFormPage` dengan `Navigator.push()`. Opsi Home di drawer menggunakan `Navigator.pushReplacement()` untuk mengganti halaman formulir dengan `MyHomePage`.

2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

= `Scaffold` menyediakan kerangka halaman, termasuk area konten, `AppBar`, dan `Drawer`. Form Education memakai `Scaffold` dengan `AppBar` indigo dan `LeftDrawer` yang sama dengan halaman utama. Warna indigo juga digunakan pada header drawer dan tombol simpan, sehingga tampilannya selaras dengan tema portofolio.

3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

= Form disusun dengan `SingleChildScrollView` dan `Column` agar input tetap tersusun vertikal dan dapat digulir saat ruang layar terbatas atau keyboard terbuka. `Padding` memberi jarak di sekitar setiap input, sedangkan `SizedBox` memberi jarak antara kolom tahun mulai dan tahun selesai. Dengan begitu, tombol Save tetap dapat dijangkau dengan menggulir halaman.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

= `GlobalKey<FormState>` menghubungkan tombol Save ke state formulir. Saat tombol ditekan, `_formKey.currentState!.validate()` menjalankan validator setiap kolom; jika ada kolom wajib kosong atau tidak valid, pesan kesalahan ditampilkan dan dialog ringkasan tidak dibuka. Contohnya, tahun mulai `abc` ditolak karena bukan angka dalam rentang 1900–2100. `keyboardType: TextInputType.number` hanya meminta papan ketik angka, tetapi tidak mencegah semua teks masuk, sehingga nilai tetap perlu diperiksa oleh validator.

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

# D11
Nama anggota:
- Ahmad Omar Mohammed Maknoon
- Raditya Amoret
- Chris Darren Imanuel
- Raihana Nur Azizah
- Renata Gracia Adli

# SPORTSCOPE TODAY [Aplikasi Mobile Majalah Olahraga Interaktif]
Sportscope Today adalah platform majalah olahraga digital interaktif yang menyajikan berita terkini, hasil pertandingan, serta forum diskusi bagi para penggemar sepak bola. Pengguna dapat membaca artikel terbaru, menandai konten favorit, serta berdiskusi di forum komunitas yang dinamis.

Aplikasi ini dirancang untuk menjadi pusat informasi dan interaksi bagi pecinta Liga Premier Inggris maupun penggemar sepak bola secara umum.

# Modul untuk setiap anggota
## 1. Dashboard
Berfungsi sebagai beranda utama yang menampilkan ringkasan konten penting:
- Welcoming page.
- Berita sepak bola terbaru.

## 2. Halaman News (Renata Gracia Adli)
Berisi daftar berita olahraga yang disusun berdasarkan kategori atau tanggal rilis. Fitur yang tersedia:
- Filter berita dari latest ke oldest.
- Fitur pencarian berita tertentu.
- Tombol Bookmark untuk menyimpan berita favorit.
- Tampilan detail berita.

## 3. History Pertandingan (Raihana Nur Azizah)
Fitur ini menampilkan rekap hasil pertandingan sebelumnya.
- Data mencakup skor akhir pertandingan.
- Pengguna dapat melihat history by team atau by competition.

## 4. Forum (Ahmad Omar Mohammed Maknoon)
Ruang diskusi komunitas yang mirip konsepnya dengan Reddit/Quora. Terdapat 3 jenis forum yang tersedia:
- Forum General: tempat untuk membahas topik umum seputar olahraga. 
- Forum by Category: membahas topik spesifik seperti liga tertentu, klub favorit, atau pemain.
- Forum reply : forum yang membahas suatu artikel atau hasil pertandingan tertentu.

Fitur tambahan: 
- Tombol bookmark untuk menyimpan forum favorit.
- Tombol like komentar pada forum.

Peran lain:
- Membuat fitur autentikasi yang dapat mengenali pengguna berdasarkan rolenya sebagai acuan validasi fitur-fitur khusus.
- Membuat CustomAppBar dan Left Drawer sebagai navigasi utama antarmodul pada aplikasi.

## 5. Daftar Pemain FIFA (Chris Darren Imanuel)
Berisi data dan profil pemain sepak bola dari database FIFA.

Fiturnya dapat menampilkan data pemain lengkap seperti nama, posisi, tim, dan statistik performa. Dapat diurutkan berdasarkan posisi, rating, atau popularitas (likes). Menyediakan fitur pencarian untuk menemukan pemain tertentu. Modul ini juga dapat menampilkan gambar pemain secara otomatis berdasarkan slug yang sesuai.

# Peran Pengguna
Admin
1. Dapat membuat, mengedit, dan menghapus artikel berita olahraga.
2. Dapat menambahkan dan mengedit history match di halaman terkait.
3. Dapat menghapus postingan dan komentar di forum (yang melanggar aturan).
4. Dapat membuat, mengedit, dan menghapus player.
   
User
1. Dapat membuat postingan, mengedit postingan yang dibuat, dan mengomentrasi postingan orang lain di forum.
2. Dapat bookmark berita dan thread forum.
3. Dapat memberikan love pada daftar pemain sepak pola.

# Alur Integrasi dengan Web Service
Django digunakan sebagai backend yang menyediakan layanan web berupa REST API, sementara Flutter bertindak sebagai frontend yang mengonsumsi seluruh layanan tersebut. Semua endpoint web service ditempatkan dalam sebuah Django app khusus bernama api, dan seluruh rute layanan diakses melalui prefix /api/. Berikut penjelasan untuk setiap bagiannya.

## Backend Django

Backend dikembangkan menggunakan Django yang dikonfigurasi untuk memberikan respons berupa JSON. Pada tahap pertama, Django diatur agar mendukung CORS sehingga permintaan dari aplikasi Flutter yang berjalan pada domain atau port berbeda dapat diterima. App api dibuat sebagai pusat layanan web service. Di dalam app ini disediakan endpoint khusus untuk autentikasi (login, register, logout) serta endpoint lain seperti pengambilan dan pengiriman data. Seluruh endpoint tersebut diakses melalui prefix /api/, misalnya /api/auth/login atau /api/products. Django kemudian mengelola request yang masuk, memvalidasi data, berkomunikasi dengan database, dan mengembalikan hasil dalam format JSON yang mudah diolah Flutter.

## Frontend Flutter

Flutter bertindak sebagai client yang mengonsumsi web service dari Django. Integrasi dilakukan melalui request HTTP dari Flutter ke endpoint Django yang berada di bawah prefix /api/. Flutter menggunakan mekanisme penyimpanan cookie sehingga dapat memanfaatkan session authentication dari Django, memungkinkan pengguna tetap login selama sesi masih berlaku. Ketika pengguna melakukan login, Flutter mengirim data kredensial ke endpoint login di Django. Jika berhasil, Django memberikan cookie session yang kemudian disimpan Flutter sehingga request berikutnya dikenali sebagai request dari pengguna yang sudah terautentikasi. Flutter juga membuat model internal untuk mengubah data JSON yang diterima dari Django menjadi struktur data yang dapat ditampilkan melalui antarmuka aplikasi.

# Link Figma
https://www.figma.com/design/BoAdJpI4ZLFqdBl1l0uvQ9/PAS-D11?node-id=0-1&t=wXlkXAALBu2bCj3N-1 


last update: 26/11/2025 4 PM due to adjusment in task distribution


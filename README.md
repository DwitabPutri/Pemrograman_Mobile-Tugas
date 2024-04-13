# tgs1_progmob

Nama : Ni Kadek Dwita Putri Suastini

NIM : 2205551074

Mata Kuliah : Pemrograman Mobile (C)

Aplikasi debug terdiri atas 5 halaman, yaitu :
1. halaman pertama berisi logo dari aplikasi Finease
2. halaman kedua berisi penjelasan aplikasi dan pilihan untuk membuat akun atau masuk ke akun yang telah dibuat
3. halaman ketiga adalah halaman yang digunakan untuk membuat akun baru
4. halaman keempat adalah halaman yang digunakan untuk masuk ke akun yang telah dibuat
5. dan halaman terakhir yaitu halaman kelima adalah halaman home atau beranda yang berisikan list pengguna dalam bentuk dummy.

   
Adapun berikut adalah tampilan dari masing-masing halaman.
   
[1] Halaman Pertama Finease

   ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/c9d3e90a-fe9c-4c9f-a0ff-47870c99440f)

Apabila pengguna menekan lanjut, maka akan diarahkan ke halaman berikutnya yaitu halaman kedua

[2] Halaman Kedua

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/8aaf48f4-ab99-4ff0-832d-1980df8b2a84)

Pada halaman ini:

  apabila pengguna menekan kembali, maka akan diarahkan ke halaman pertama.
  
  terdapat tiga pilihan, yaitu :
  
  1. Buat akun baru : apabila pengguna menekan tombol ini, maka akan diarahkan ke halaman ketiga yaitu untuk membuat akun baru
    
  2. Lanjutkan dengan google : button ini tidak akan mengarahkan kemanapun
    
  3. Masuk : apabila pengguna menekan teks masuk yang bergaris bawah, maka akan diarahkan ke halaman keempat yaitu untuk masuk ke akun yang sudah ada
    
[3] Halaman Ketiga - Membuat Akun Baru

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/05ebb24b-8e9f-4930-ad81-c2db940fe4f3)

Pada halaman ini ada 4 text field yang harus diisikan agar bisa membuat akun, yaitu alamat email, nomor telepon, password, dan konfirmasi password. Pengguna juga harus menyentang check box agar bisa melanjutkan proses pembuatan akun. Setiap text field berisi validasi termasuk check box. Adapun apabila pengguna tidak memenuhi syarat atau validasi, maka akan ada pesan error yang ditampilkan seperti berikut.

  1. Alamat Email
     
     [1] Apabila pengguna tidak menginputkan email sesuai dengan format email yang kerap ditemukan, maka :
     
     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/260ce472-bfed-44fd-96e1-b61b1b10ec20)

     [2] Apabila alamat email telah sesuai dengan format email, maka tidak akan ada pesan error :

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/fa1aca92-5408-42ad-8364-daad896401bd)
     

  3. Nomor Telepon
     
     [1] Apabila nomor telepon yang diinputkan oleh pengguna tidak memenuhi >=10  atau berisikan karakter selain angka, maka :

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/a0a4dfbd-e7cb-476c-9767-3a87084ef616)

     [2] Apabila nomor telpon yang diinputkan memenuhi syarat validasi, maka tidak akan ada pesan error :

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/2b93301c-c0c4-4068-bec3-c9a6d0b2c434)

     
  4. Password
     
     [1] Syarat password yang bisa diterima hanyalah harus >= 1 karakter dan bebas menggunakan kombinasi karakter apapun (angka, huruf, simbol). Pengguna juga bisa menyembunyikan dan                 melihat password yang diinputkan dengan menekan gambar mata di sebelah password dan konfirmasi password seperti berikut.

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/a0340735-78bb-41c5-887e-4e75ae3b4439)

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/07c3e86e-96c6-4dc7-adb3-e06a1322d4d2)

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/24764c02-816d-485f-954a-0eaf2c5994ac)


  5. Konfirmasi Password
     
     [1] Konfirmasi password akan dianggap benar apabila password = konfirmasi password, jika tidak, maka akan ada pesan error seperti berikut ini :

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/0256d4f5-f088-49d4-868e-367bc3551d0e)

     [2] Apabila password = konfirmasi password, maka tidak akan ada pesar error :

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/afa2208e-df76-4f15-999f-4a417ce82519)
     
  6. Check box
     
     [1] Pengguna juga harus memastikan untuk menyentang check box, jika tidak, maka ketika menekan button buat akun baru, akan ada alert yang menunjukkan error sebagai berikut :

     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/9c8cf089-5cdc-4827-a0a8-a89a02ad6cd3)

Secara keseluruhan, apabila terdapat error pada texfield maupun checkbox yang diakibatkan oleh validasi, maka terdapat alert error seperti ini :

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/33796215-4797-4e79-a523-e0247a4ae458)

Untuk menutup alert, pengguna bisa mengklik bebas di manapun. Kemudian pengguna harus memperbaiki text field atau check box yang error dan menekan button buat akun kembali. Jika semua syarat telah terpenuhi, maka akan tampil alert sukses sebagai berikut :

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/ea942857-60a6-4fea-b0ed-7afbce4db4c0)

Setelah ada alert sukses, pengguna perlu mengunggu selama 2 detik dan secara otomatis halaman akan langsung dialihkan ke halaman home. Pengguna tidak perlu menekan apapun untuk melanjutkan proses menuju halaman home. Namun, apabila pengguna ingin menutup atau menghilangkan alert, pengguna bisa menekan di manapun.

Jika pengguna menekan text "Masuk" pada halaman ketiga, maka akan dialihkan ke halaman keempat yaitu untuk masuk ke akun yang sudah ada. Jika pengguna menekan teks kembali, maka akan dialihkan ke halaman kedua.

[4] Halaman Keempat - Masuk ke Akun yang Ada

Pada halaman ini, hanya ada 2 text field yang wajib diisikan, yaitu alamat email atau nomor telepon, dan password.

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/e7ab953a-db7e-4aaa-855b-b77f7a7d8a34)

  1. Alamat email atau nomor telepon
     
     [1] Pengguna bisa menginputkan alamat email yang sesuai atau nomor telepon yang sesuai, misalnya seperti berikut ini :
  
     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/d3e5c958-0914-4524-8405-84d6172023fc)
  
     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/d16bdd89-b6ff-4225-95cd-c339f8b17fcc)
  
     [2] Apabila alamat email yang diinputkan tidak sesuai format, begitu juga dengan nomor telepon, maka akan ada pesan error seperti berikut ini :
  
     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/0a99829f-40bd-4059-870f-1c8650f50f79)
  
  2. Password
  
     Sama seperti validasi password saat membuat akun, syarat yang harus dipenuhi hanyalah lebih dari 1 karakter dengan kombinasi bebas. Pengguna juga bisa melihat atau menyembunyikan password       yang diinputkan
  
     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/537fbe28-68e9-4420-89d5-a845e47f4eb6)
  
     ![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/79295840-f773-43f4-bd4d-40cf297a5503)

Jika ada text field yang error atau salah, maka akan ada alert gagal seperti berikut.

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/b2a6921c-4da3-43cf-a714-8ebfb35719dc)

Jika semua text field telah diisikan dengan benar, maka ketika pengguna menekan tombol masuk akan ada alert sukses seperti berikut.

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/4ff846cd-2f22-4c33-9992-3a5c4d483214)

Setelah ada alert sukses, pengguna perlu mengunggu selama 2 detik dan secara otomatis halaman akan langsung dialihkan ke halaman home. Pengguna tidak perlu menekan apapun untuk melanjutkan proses menuju halaman home. Namun, apabila pengguna ingin menutup atau menghilangkan alert, pengguna bisa menekan di manapun.

Jika pengguna menekan text "Buat Akun" pada halaman keempat, maka akan dialihkan ke halaman ketiga yaitu untuk membuat akun baru. Jika pengguna menekan teks kembali, maka akan dialihkan ke halaman kedua.

[5] Halaman Home

Halaman home berisi appbar, body dan di dalamnya terdapat bottom navigation bar yang berisi tombol atau icon yang bisa mengarahkan ke halaman lainnya. Namun untuk saat ini, icon-icon tersebut belum bisa digunakan untuk navigasi atau pindah halaman. List pengguna terdiri atas 25 list dan dapat discroll atau gulir. Appbar dan bottom navigation bar tidak akan ikut tergulir ketika list pengguna discroll.

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/0c011c3a-fabf-4c37-9fab-798d35fc3775)

![image](https://github.com/DwitabPutri/Pemrograman_Mobile-Tugas1/assets/114004174/cf6b222e-a686-4095-9123-bb8df39e492d)




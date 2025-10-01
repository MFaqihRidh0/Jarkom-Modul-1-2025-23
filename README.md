# LAPRES Praktikum Sistem Operasi Modul 4 - IT14

## Anggota
1. M. Faqih Ridho - 5027241123
2. Kaisar Hanif Pratama - 5027241029


## DAFTAR ISI
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)



1


Langkah pengerjaan:
Buatlah  ervn-debi dan NAT. Sambungkan nat0 dan eth0. Rename ervn-debi menjadi Eru
Buatlah 2 switch. Sambungkan kedua switch ke Eru. 
Buatlah 4 ervn-debi dan sambungkan 2 ervn-debi ke salah satu switch.
Rename masing-masing menjadi Meikor, Manwe, Varda, Ulmo.
Kendala:
Bingung cara untuk membuat dan menyambungkannya

2. 
Langkah pengerjaan:
Klik kanan di Eru. Klik Configure
Klik “Edit Network Configuration”
Cari “# auto eth0 # iface eth0 inet dhcp” Uncomment dan Save.
Klik start, ethonya akan menjadi hijau

Kendala:
Membutuhkan banyak percobaan untuk berfungsi


3. 
Langkah pengerjaan:
Sambungkan Melkor dan Manwe ke Switch1
Sambungkan Varda dan Ulmo ke Switch2
Sambungkan kedua switch tersebut ke Eru
Ping ke satu client ke client lain
Perintahnya merupakan echo nameserver 192.168.122.1 > /etc/resolv.conf
Kalau sudah terkoneksi. Selamat, anda sudah berhasil

Kendala
Tidak ada kendala sama sekali

4. 




Langkah pengerjaan
Buka Ubuntu
Masukkan telnet di masing-masing node
Ping masing-masing 
Cek apakah konsolnya bisa dipakai

Kendala
Tidak ada kendala
5. 
Langkah Pengerjaan
Stop semua node

Kendala
Tidak ada kendala sama sekali

6. 

Langkah pengerjaan
Sambungkan malkor ke manwe dan eru
Download link traffic.sh
 Nano file tersebut di manwe
Echo cat dan ping manwe dan eru
Capture di Switch1_Ethernet2_to_Manwe_eth0

Kendala
Bingung menggunakan wireshark
Bingung cara memasukkan file tersebut ke ubuntu
Memerlukan banyak percobaan untuk mendapatkan capturenya

7.

14.

























# LAPRES Praktikum Kmunikasi Data dan Jaringan Komputer Modul 1 - K-23

## Anggota
1. M. Faqih Ridho - 5027241123
2. Kaisar Hanif Pratama - 5027241029


## Pengerjaan

1. 


<img width="823" height="318" alt="Screenshot 2025-09-30 153946" src="https://github.com/user-attachments/assets/eed16ee9-6045-41e9-9631-d897fb71d4ad" />


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

14.  Soal pertama **How many packets are recorded in the pcapng file?**
    Cara mengerjakan : tekan tombol Statistics diatas → pilih Capture File Properties → Lihat packets
    Jawabannya  500358

<img width="675" height="403" alt="Soal 14 nomer 1 berapa jumlah packet" src="https://github.com/user-attachments/assets/cb05f532-b8c0-4abe-a5c0-01741f0ddf66" />


Soal kedua **What are the user that successfully logged in?**
Cara mengerjakannya : 1. masukkan filter di wireshark http.response.code == 200 && http contains "Success! Login successful."
2. Klik kanan salah satu paket
3. lalu pilih follow
4. lalu pilih TCP stream

Jawabannya : n1enna:y4v4nn4_k3m3nt4r1

<img width="569" height="401" alt="Soal 14 nomer 2" src="https://github.com/user-attachments/assets/f1d689bc-1419-4095-9eff-4ef67b5d8f61" />



Soal ketiga **In which stream were the credentials found?**

Jawabannya: 41824 (dapat di lihat pada gambar dari soal 2, dibagian atas panel)

SOal Keempat **What tools are used for brute force?**
Cara mengerjakannya : 1. Masukkan filter http || tcp.port == 80 || tcp.port == 8000
2. Lihat panel dan klik hypertext transfer protocol 


<img width="656" height="388" alt="image" src="https://github.com/user-attachments/assets/7cef94b2-2234-4109-8fd6-4e66beb977d1" />





























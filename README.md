# LAPRES Praktikum Kmunikasi Data dan Jaringan Komputer Modul 1 - K-23

## Anggota
1. M. Faqih Ridho - 5027241123
2. Kaisar Hanif Pratama - 5027241029


## Pengerjaan

1. 


<img width="948" height="600" alt="Screenshot 2025-10-01 221223" src="https://github.com/user-attachments/assets/ed55a0e7-8edf-450a-975d-1fd58a015925" />



Langkah pengerjaan:
Buatlah  ervn-debi dan NAT. Sambungkan nat0 dan eth0. Rename ervn-debi menjadi Eru
Buatlah 2 switch. Sambungkan kedua switch ke Eru. 
Buatlah 4 ervn-debi dan sambungkan 2 ervn-debi ke salah satu switch.
Rename masing-masing menjadi Meikor, Manwe, Varda, Ulmo.
Kendala:
Bingung cara untuk membuat dan menyambungkannya

2. 

<img width="944" height="444" alt="Screenshot 2025-09-30 184647" src="https://github.com/user-attachments/assets/7d53344c-07a8-414a-ac7c-16290651cf0f" />

Langkah pengerjaan:
Klik kanan di Eru. Klik Configure
Klik “Edit Network Configuration”
Cari “# auto eth0 # iface eth0 inet dhcp” Uncomment dan Save.
Klik start, ethonya akan menjadi hijau

Kendala:
Membutuhkan banyak percobaan untuk berfungsi


3. 

<img width="890" height="211" alt="Screenshot 2025-10-01 133703" src="https://github.com/user-attachments/assets/d228544e-ee78-4ebc-a08b-f7cc58d309af" />
<img width="824" height="218" alt="Screenshot 2025-10-01 134439" src="https://github.com/user-attachments/assets/52475397-3443-44a6-bce5-8187a217096e" />
<img width="871" height="168" alt="Screenshot 2025-10-01 134523" src="https://github.com/user-attachments/assets/b42133c0-0193-4041-930b-eecaacd93326" />
<img width="859" height="218" alt="Screenshot 2025-10-01 135411" src="https://github.com/user-attachments/assets/5d0685a4-ac74-46a2-9af4-428a0da497cc" />

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

Soal Keempat **What tools are used for brute force?**

Cara mengerjakannya : 
1. Masukkan filter http || tcp.port == 80 || tcp.port == 8000
  
2.  Lihat panel dan klik hypertext transfer protocol 


<img width="656" height="388" alt="image" src="https://github.com/user-attachments/assets/7cef94b2-2234-4109-8fd6-4e66beb977d1" />

**Congratulations! Here is your flag: KOMJAR25{Brut3_F0rc3_vJF0HeOMZznoZ1t8dxTamlLLn}**


17. Soal Pertama **What is the name of the first suspicious file?**
   Cara Mengerjakannya :
1. Klik file
2. Lalu pilih export object
3. Lalu pilih HTTP
4. Lihat folder untuk melihat file yang terdownload

Jawaban Invoice&MSO-Request.doc



Soal kedua **What is the name of the second suspicious file?**
Cara mengerjakannya : 1. sama seperti soal pertama

Jawaban :  knr.exe

<img width="204" height="74" alt="image" src="https://github.com/user-attachments/assets/7f520589-46a3-4c8b-b63f-58d543cbc965" />
  
    Soal Ketiga **What is the hash of the second suspicious file (knr.exe)?**
    Cara mengerjakannya :
1. Masuk folder dari workspace
2.Masukkan beberapa filter berikut terminal :
masukkan file knr.exe
sha256sum knr.exe
md5sum knr.exe

Jawaban : 749e161661290e8a2d190b1a66469744127bc25bf46e5d0c6f2e835f4b92db18


<img width="404" height="99" alt="checksum knr exe nomer 17" src="https://github.com/user-attachments/assets/dcdcda57-5bf3-4fce-a97a-395403e9b625" />


**Congratulations! Here is your flag: KOMJAR25{M4ster_4n4lyzer_lVxv2LcXUwziQXHA5LTI3C0cW}**



























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

<img width="860" height="588" alt="Screenshot 2025-10-01 131312" src="https://github.com/user-attachments/assets/2a7cb827-2a65-4753-bc02-863bffb7bd2f" />

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

<img width="890" height="211" alt="Screenshot 2025-10-01 133703" src="https://github.com/user-attachments/assets/d228544e-ee78-4ebc-a08b-f7cc58d309af" />
<img width="824" height="218" alt="Screenshot 2025-10-01 134439" src="https://github.com/user-attachments/assets/52475397-3443-44a6-bce5-8187a217096e" />
<img width="871" height="168" alt="Screenshot 2025-10-01 134523" src="https://github.com/user-attachments/assets/b42133c0-0193-4041-930b-eecaacd93326" />
<img width="859" height="218" alt="Screenshot 2025-10-01 135411" src="https://github.com/user-attachments/assets/5d0685a4-ac74-46a2-9af4-428a0da497cc" />



Langkah pengerjaan
Buka Ubuntu
Masukkan telnet di masing-masing node
Ping masing-masing 
Cek apakah konsolnya bisa dipakai

Kendala
Tidak ada kendala

5. 

<img width="1403" height="594" alt="Screenshot 2025-10-01 141451" src="https://github.com/user-attachments/assets/95c5e4ed-33c2-484f-965b-c26049d078b6" />

Langkah Pengerjaan
Stop semua node

Kendala
Tidak ada kendala sama sekali

6. 


<img width="877" height="554" alt="Screenshot 2025-10-01 173534" src="https://github.com/user-attachments/assets/9b1a3614-de2f-4df3-bce2-703f1f4d9caa" />
<img width="967" height="595" alt="Screenshot 2025-10-01 194511" src="https://github.com/user-attachments/assets/5f5341ce-86c9-4f7b-a364-065df9827ad1" />

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
Cara mengerjakannya :

1. masukkan filter di wireshark http.response.code == 200 && http contains "Success! Login successful."
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
  
Klik file -> Lalu pilih export object -> Lalu pilih HTTP -> Lihat folder untuk melihat file yang terdownload

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

18. Soal pertama **How many files are suspected of containing malware?**
Jawaban : 2

Soal kedua **What is the name of the first malicious file?**
Jawaban : d0p2nc6ka3f_fixhohlycj4ovqfcy_smchzo_ub83urjpphrwahjwhv_o5c0fvf6.exe

Soal ketiga **Apa nama file berbahaya yang kedua?**
Jawaban: oiku9bu68cxqenfmcsos2aek6t07_guuisgxhllixv8dx2eemqddnhyh46l8n_di.exe

Soal Keempat **What is the hash of the first malicious file?**
Jawaban :  59896ae5f3edcb999243c7bfdc0b17eb7fe28f3a66259d797386ea470c010040

Soal kelima **What is the hash of the second malicious file?**
Jawaban : cf99990bee6c378cbf56239b3cc88276eec348d82740f84e9d5c343751f82560


<img width="524" height="152" alt="image" src="https://github.com/user-attachments/assets/c165ce37-ad58-4f10-92dd-a6a5009d1529" />

    cara mengerjakannya: 
    
a. masuk ke folder workspace di terminal
b. masukkan filter
c. File akan terdownload semuanya di folder kerja
d.di soal dijelaskan melkor menjalankan serangan yang berbeda jadi selain yang HTTP
 
 ```
PCAP="MelkorPlan3.pcap"
mkdir -p dump_http dump_smb dump_tftp dump_imf unpack
tshark -r "$PCAP" --export-objects "http,dump_http"
tshark -r "$PCAP" --export-objects "smb,dump_smb"   2>/dev/null
tshark -r "$PCAP" --export-objects "tftp,dump_tftp" 2>/dev/null
tshark -r "$PCAP" --export-objects "imf,dump_imf"   2>/dev/nul

````

**Congratulations! Here is your flag: KOMJAR25{Y0u_4re_g0dl1ke_7HXeaLQJeC1lSyMIM9XorFzV2}**

19.  Soal pertama **Who sent the threatening message?**
Jawababan  :  Your Life

Soal kedua **How much ransom did the attacker demand ($)?**
Jawaban : 1600

Soal ketiga **What is the attacker's bitcoin wallet?**
Jawaban : 1CWHmuF8dHt7HBGx5RKKLgg9QA2GmE3UyL

Cara Mengerjakan
1. Masukkan filter smtp || tcp.port==25
2. Klik kanan salah satu paket
3. Lalu pilih follow
4. Lalu pilih TCP Stream
5. Suratnya akan tersusun
6. Baca suratnya untuk menjawab soal-soal yang diberikan 

<img width="661" height="415" alt="soal 19 email penyerang" src="https://github.com/user-attachments/assets/391b1d3f-e1af-496b-8d95-55809a0bafc4" />


**Congratulations! Here is your flag: KOMJAR25{Y0u_4re_J4rk0m_G0d_YKcNyQokVU7eUF8kq6mHfZ7vw}**

























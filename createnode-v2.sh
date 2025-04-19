#!/bin/bash


# Minta input dari pengguna.
echo "Masukkan nama lokasi: "
read location_name
echo "Masukkan deskripsi lokasi: "
read location_description
echo "Masukkan domain: "
read domain
echo "Masukkan nama node: "
read node_name
echo "Masukkan RAM (dalam MB): "
read ram
echo "Masukkan jumlah maksimum disk space (dalam MB): "
read disk_space
echo "Masukkan Locid: "
read locid

# Ubah ke direktori pterodactyl
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# Membuat node baru
php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

read -p "Masukkan IP address untuk allocation: " ip_address
  read -p "Masukkan Port (contoh: 25565): " port
  read -p "Masukkan IP alias (boleh kosong): " ip_alias

php artisan p:allocation:make <<EOF
$node_name
$ip_address
$port
$ip_alias
EOF

echo "Proses pembuatan lokasi dan node telah selesai."
exit 0
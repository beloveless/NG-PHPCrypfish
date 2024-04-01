#! /bin/bash
total_start_time=$(date +%s) # Waktu mulai keseluruhan

temp_file=$(mktemp) # Membuat file sementara untuk menyimpan waktu eksekusi

for y in $(seq 1 100); do
    (
    for x in $(seq 1 100); do
        start_time=$(date +%s) # Waktu mulai
        response=$(curl -s "http://${{ env.URL }}/login.php")
        end_time=$(date +%s) # Waktu selesai
        elapsed_time=$((end_time - start_time)) # Waktu eksekusi

         echo $elapsed_time >> $temp_file # Menyimpan ke file sementara
    done
    ) &
done

wait # Menunggu semua proses latar belakang selesai

total_elapsed_time=0
while read time; do
    total_elapsed_time=$((total_elapsed_time + time))
done < $temp_file

# Menghitung total waktu dalam menit dan detik
total_minutes=$((total_elapsed_time / 60))
total_seconds=$((total_elapsed_time % 60))

echo "Total Elapsed Time: ${total_minutes} minutes and ${total_seconds} seconds"

rm $temp_file # Membersihkan file sementara

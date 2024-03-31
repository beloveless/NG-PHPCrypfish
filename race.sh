#! /bin/bash
echo "hello"
i=1
for y in $(seq 1 100)
do
    (for x in $(seq 1 100)
    do
        start_time=$(date +%s%N) # Waktu mulai dalam nanodetik
        response=$(curl -s "http://${{ env.URL }}/login.php?id=1&amount=100")
        end_time=$(date +%s%N) # Waktu selesai dalam nanodetik
        elapsed_time=$((end_time - start_time)) # Waktu eksekusi dalam nanodetik
        
        echo "Response from curl: $response"
        echo "Elapsed time: $((elapsed_time / 1000000)) ms" # Konversi ke milidetik
    done) &
done

#! /bin/bash
echo "hello"
total_start_time=$(date +%s%N) # Waktu mulai keseluruhan

temp_file=$(mktemp) # Membuat file sementara untuk menyimpan waktu eksekusi

for y in $(seq 1 100); do
    (
    for x in $(seq 1 100); do
        start_time=$(date +%s%N) # Waktu mulai
        response=$(curl -s "http://${{ env.URL }}/login.php?id=1&amount=100")
        end_time=$(date +%s%N) # Waktu selesai
        elapsed_time=$((end_time - start_time)) # Waktu eksekusi
        echo $((elapsed_time / 1000000)) >> $temp_file # Menyimpan ke file sementara
    done
    ) &
done

wait # Menunggu semua proses latar belakang selesai

total_elapsed_time=0
while read time; do
    total_elapsed_time=$((total_elapsed_time + time))
done < $temp_file

echo "Total Elapsed Time: $total_elapsed_time ms"

rm $temp_file # Membersihkan file sementara

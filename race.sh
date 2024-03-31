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
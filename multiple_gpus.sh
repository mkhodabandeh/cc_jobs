pids=""

for i in `seq 0 4`; do
   python mycode.py $i &
   pids="$pids $!"
done

wait $pids

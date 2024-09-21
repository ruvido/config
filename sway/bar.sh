while true
do
    da=$(date +" %A %d.%m • %R  ")
    ac=$(cat /sys/class/power_supply/AC/online)
    if [ "$ac" == "1" ]; then
        ac=""
    else
        ac="$(cat cat /sys/class/power_supply/BAT0/capacity)%"
    fi
    echo "$da $ac  " 
    sleep 1
done 

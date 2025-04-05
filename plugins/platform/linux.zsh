if [[ "$MY_DISTRO" == "WSL" ]];then
   # wsl
   alias win="explorer.exe ."
   
   # X.Org server
   #export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
   #export LIBGL_ALWAYS_INDIRECT=1
fi

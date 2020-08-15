
# Display
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0

# fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export DefaultIMModule=fcitx

# snap
# Expand $PATH to include the directory where snappy applications go.
snap_bin_path="/snap/bin"
if [ -n "${PATH##*${snap_bin_path}}" -a -n "${PATH##*${snap_bin_path}:*}" ]; then
  export PATH=$PATH:${snap_bin_path}
fi

# genie
if [ "`ps -eo pid,lstart,cmd | grep systemd | grep -v -e grep -e systemd- | sort -n -k2 | awk 'NR==1 { print $1 }'`" != "1" ]; then
  # genie -s not working
  # https://github.com/arkane-systems/genie/issues/28#issuecomment-542678336
  genie -c bash
else
  # fcitx start
  fcitx-autostart > /dev/null 2>&1
fi



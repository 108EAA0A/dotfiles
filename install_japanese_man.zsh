#!/bin/zsh -eux

DOT_DIR="${HOME}/dotfiles"

echo "install japanese man..."

TAB="$(printf '\\\011')"
sudo sed -i '.bak' -E "s@^JNROFF(${TAB}+).*@JNROFF\1/usr/local/bin/nkf -w | /usr/local/bin/groff -Dutf8 -Tutf8 -mandoc -mja -E@" /etc/man.conf
sudo sed -i -e 's/less -is$/less -isr/g' /etc/man.conf
sudo sed -i -e 's@^MANPATH_MAP\(.*\)/usr/share/man$@MANPATH_MAP\1/usr/local/share/man@' /etc/man.conf

LATEST_JA_MAN_DATE="$(date '+%Y%m15' --date '-1 months')"
LATEST_JA_MAN="man-pages-ja-${LATEST_JA_MAN_DATE}"
curl -fsSL "http://linuxjm.osdn.jp/${LATEST_JA_MAN}.tar.gz" | tar xf - -C /tmp/
(
  set -eux
  cd "/tmp/${LATEST_JA_MAN}" || exit
  expect "${DOT_DIR}/man-jp-make-config.expect"
  sudo make install
) > "/tmp/${LATEST_JA_MAN}/install.log" 2>&1
command cat "/tmp/${LATEST_JA_MAN}/install.log"

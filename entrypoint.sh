#!/bin/bash
if [[ $1 =~ ^[0-9]+$ ]]
then
  target_uid=$1
  shift

  [[ $(id -u squeezeboxserver) != $target_uid ]] && usermod -u $target_uid squeezeboxserver
fi

if [[ -n $TZ ]]
then
    echo $TZ > /etc/timezone
fi

exec -l chroot --userspec squeezeboxserver / squeezeboxserver $@

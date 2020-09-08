#!/bin/sh
# Git Clone iocage jail install scripts under FreeNAS 11.3
# https://github.com/NasKar2/freenas-iocage-clone

# Check for root privileges
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run with root privileges"
   exit 1
fi

# Initialize defaults

POOL_PATH=""
GIT_PATH=""

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
. $SCRIPTPATH/clone-config
CONFIGS_PATH=$SCRIPTPATH/configs
RELEASE=$(freebsd-version | sed "s/STABLE/RELEASE/g" | sed "s/-p[0-9]*//")

# Check for clone-config and set configuration
if ! [ -e $SCRIPTPATH/clone-config ]; then
  echo "$SCRIPTPATH/clone-config must exist."
  exit 1
fi

if [ -z $POOL_PATH ]; then
  echo 'Configuration error: POOL_PATH must be set'
  exit 1
fi

if [ -z $GIT_PATH ]; then
  echo 'Configuration error: APPS_PATH must be set'
  exit 1
fi

#
# git clone repositories
#
${GIT_PATH}=${POOL_PATH}/${GIT}
mkdir -p ${GIT_PATH}
cd ${GIT_PATH}
git clone https://github.com/NasKar2/freenas-iocage-sepapps.git
git clone https://github.com/NasKar2/freenas-iocage-other.git
git clone https://github.com/NasKar2/freenas-iocage-backupapps.git
git clone https://github.com/NasKar2/freenas-iocage-configs_backup.git
#git clone https://github.com/NasKar2/freenas-iocage-nextcloud.git
mkdir ${GIT_PATH}/danb35
cd ${GIT_PATH}/danb35
git clone https://github.com/danb35/freenas-iocage-nextcloud.git
git clone https://github.com/danb35/freenas-iocage-caddy.git
git clone https://github.com/danb35/freenas-iocage-plex.git



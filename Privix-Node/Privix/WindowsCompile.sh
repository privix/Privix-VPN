#!/bin/bash
# Copyright (c) 2019 Node_Install. Released under the MIT License.

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="WindowsCompile Wizard"
TITLE="WindowsCompile Setup"
MENU="Choose either 64bit or 32bit:"

OPTIONS=(1 "Windows 64"
		 2 "Windows 32"
		 0 "Exit Script"
)


CHOICE=$(whiptail --clear\
		--backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        0)  # Exit
		exit	
		;;

        1)	# 64 Bit
###############
# Colors Keys #
###############
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

############################
# Bring in the coins specs #
############################
source ./specs.sh

###################
# Install Depends #
###################
cd
cd $DEPENDS_PATH
bash WindowsDepends.sh
clear
echo VPS Server prerequisites installed.


####################
# Compile the Coin #
####################
cd
git clone $GITHUB
sudo chmod -R 755 $REPO_NAME
cd $REPO_NAME
cd depends
make HOST=x86_64-w64-mingw32
cd ..
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/
make
cd src
cd qt
strip $COIN_QT.exe

echo "Open up Winscp and connect to you vps that you compile this with. The location of the exe file is located 
	  CoinCompiled/src/qt/    The exe file will be in the qt folder and has already been striped.
	  If you need to install winscp you can get it here: https://winscp.net/eng/index.php"
        ;;

		2)	# 32 Bit
###############
# Colors Keys #
###############
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

############################
# Bring in the coins specs #
############################
source ./specs.sh

###################
# Install Depends #
###################
cd
cd $DEPENDS_PATH
bash WindowsDepends.sh
clear
echo VPS Server prerequisites installed.


####################
# Compile the Coin #
####################
cd
git clone $GITHUB
sudo chmod -R 755 $REPO_NAME
cd $REPO_NAME
cd depends
make HOST=i686-w64-mingw32
cd ..
./autogen.sh
./configure LDFLAGS="-L`pwd`/db4/lib/" CPPFLAGS="-I`pwd`/db4/include/" --prefix=`pwd`/depends/i686-w64-mingw32
make
cd src
cd qt
strip $COIN_QT.exe

echo "Open up Winscp and connect to you vps that you compile this with. The location of the exe file is located 
	  privix-core/src/qt/    The exe file will be in the qt folder and has already been striped.
	  If you need to install winscp you can get it here: https://winscp.net/eng/index.php"
        ;;
esac
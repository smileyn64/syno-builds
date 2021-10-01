mkdir temp

sudo yum group install "Development Tools"
sudo yum install ncurses-libs.i686 glibc.i686 libstdc++.i686
sudo yum install dialog nano chrpath wget left git
sudo yum install epel-release
sudo yum install yasm

#-----cmake
sudo yum install cmake
sudo yum install cmake3
sudo alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake 10 --slave /usr/local/bin/ctest ctest /usr/bin/ctest --slave /usr/local/bin/cpack cpack /usr/bin/cpack --slave /usr/local/bin/ccmake ccmake usr/bin/ccmake  --family cmake
sudo alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 --family cmake

cd temp
wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2
tar xjvf nasm-2.15.05.tar.bz2
cd nasm-2.15.05
./autogen.sh
./configure
make
sudo make install
cd ..
rm -rf nasm-2.15.05
rm -rf nasm-2.15.05.tar.bz2

#-----set up Synology toolchain
export DL_PATH="https://sourceforge.net/projects/dsgpl/files/Tool%20Chain/DSM%207.0.0%20Tool%20Chains"

#-----Marvell Armada 375, Armada 385, Mindspeed Comcerto 2000, ST Microelectronics STiH412, and Annapurna Labs Alpine SoCs are based on dual ARM Cortex-A9 cores with NEON vector unit
#-----http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
#-----http://www.marvell.com/embedded-processors/armada-38x/assets/A38x-Functional-Spec-PU0A.pdf
#-----http://www.mindspeed.com/products/cpe-processors/comcertoreg-2000
#-----http://www.arm.com/products/processors/cortex-a/cortex-a9.php
#-----http://www.arm.com/products/processors/technologies/neon.php
#-----Since DSM 6.0 Armada 375 finally has hard float ABI and therefore gains NEON support
wget "${DL_PATH}/Marvell%20Armada%20375%20Linux%203.2.101/armada375-gcc750_glibc226_hard-GPL.txz"
tar xJf armada375-gcc750_glibc226_hard-GPL.txz
#-----Marvell gave all the ARMv7 toolchains the same name so rename to allow concurrent installations
mv arm-unknown-linux-gnueabi/ arm-cortexa9-linux-gnueabi/
wget "https://sourceforge.net/projects/dsgpl/files/toolkit/DSM7.0/ds.armada375-7.0.dev.txz"
export DEV_DL="ds.armada375-7.0.dev.txz"
export DEV_DL_ROOT="sysroot"
export CROSS_PREFIX=arm-unknown-linux-gnueabi
export TARGET=${CROSS_PREFIX}
export TOOLCHAIN=/usr/local/arm-cortexa9-linux-gnueabi
#-----it seems that in general neon should be used as the fpu when present unless there's a specific reason not to use it
export MARCH="-march=armv7-a -mcpu=cortex-a9 -mfpu=neon -mhard-float -mthumb"

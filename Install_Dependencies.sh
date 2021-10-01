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
rm -r -f nasm-2.15.05
cd ..

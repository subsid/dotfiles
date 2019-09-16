echo "yum install vim-enhanced -y"

echo "install cmake:"
echo wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz
echo tar zxvf cmake-3.*
echo cd cmake-3.*
echo ./bootstrap --prefix=/usr/local
echo make -j$(nproc)
echo make install

echo "install autojump"
echo "install fzf"
echo "Setup global virtualenv"

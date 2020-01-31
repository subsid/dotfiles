## Fix brightness control for Dell XPS"
echo "https://askubuntu.com/questions/1179384/screen-brightness-not-changing-on-dell-xps-7590"

## Useful packages
## "https://gist.github.com/rajmani1995/cae8a16056e44bd901a6d17d8f1a7fbf"
echo "sudo apt install git libpng-dev zlib1g-dev bzip2 libcanberra-gtk-module"
echo "Download Java https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html"
echo "Extract and setup like so https://stackoverflow.com/questions/6477415/how-to-set-oracles-java-as-the-default-java-in-ubuntu"
echo "sudo tar xvfz jdk-8u131-linux-i586.tar.gz -C /usr/java/"
echo "Set java home export JAVA_HOME=/usr/java/jdk1.8.0_131/"
echo "Set java /usr/bin/java version sudo update-alternatives --install /usr/bin/java java \$\{JAVA_HOME%*/\}/bin/java 20000"

echo "Insall vim Ubuntu: https://www.simplified.guide/ubuntu/install-vim"
# echo "Insall emacs Ubuntu: sudo apt install emacs"
echo "Install pyenv (git clone https://github.com/pyenv/pyenv.git ~/.pyenv) before compiling YouCompleteMe and other python stuff"
echo "yum install vim-enhanced -y"

echo "install cmake:"
echo "sudo apt-get -y install cmake"
echo wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz
echo tar zxvf cmake-3.*
echo cd cmake-3.*
echo ./bootstrap --prefix=/usr/local
echo make -j$(nproc)
echo make install

echo "install autojump"
echo "install fzf sudo apt-get install fzf"
echo "install scala https://www.codersbistro.com/blog/installing-scala-ubuntu/"
echo "If you get java error, sudo apt --fix-broken install"
echo "Install ledger cli ledger-cli.org"


echo "Enable tapping on mouspad"
echo "https://www.reddit.com/r/i3wm/comments/516e8c/tap_to_click_touchpad/"

echo "Use xrandr for resolution https://www.reddit.com/r/i3wm/comments/516e8c/tap_to_click_touchpad/"

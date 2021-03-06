unamestr=`uname`
platform='Unknown'
install_platform='generic'

# Detect the platform
if [ "$unamestr" == "Darwin" ]; then
    platform="Mac OS X"
    install_platform="macosx"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    platform="Linux"
    install_platform="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    platform="Windows"
    install_platform="mingw"
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform="FreeBSD"
    install_platform="freebsd"
elif [[ "$unamestr" == 'SunOS' ]]; then
    platform="Solaris"
    install_platform="solaris"
elif [[ "$unamestr" == 'AIX' ]]; then
    platform="AIX"
    install_platform="aix"
fi

echo "Detected platform: $platform"

# Download lua
echo "Downloading Lua 5.3.1"
curl -O http://www.lua.org/ftp/lua-5.3.1.tar.gz
tar -xf lua-5.3.1.tar.gz
rm lua-5.3.1.tar.gz
cd lua-5.3.1
echo "Building Lua 5.3.1"
make $install_platform

read -p "Path to install to: " path
cd ../

if [ -w $path ]; then
    mv lua-5.3.1/src/lua $path
else
    echo "$path requires sudo"
    sudo mv lua-5.3.1/src/lua $path
fi

echo "Installed lua to $path"

rm -rf lua-5.3.1

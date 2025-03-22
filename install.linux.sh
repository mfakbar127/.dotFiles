#!/bin/bash

mkdir /tmp/install_tool

pushd /tmp/install_tool

echo "Install essential tools"
sudo apt install tmux zsh git curl zip unzip build-essential jq xclip -y

echo "Installing aws cli"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Installing docker"
curl https://get.docker.com/ | sh

echo "Installing pip"
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

echo "Installing lsd"
wget https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd-musl_1.1.5_amd64.deb
sudo dpkg -i lsd-musl_1.1.5_amd64.deb

echo "Installing font"
declare -a fonts=(
    BitstreamVeraSansMono
    CodeNewRoman
    DroidSansMono
    FiraCode
    Hack
    Meslo
)

version='2.1.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv
## end font

popd
rm -rf /tmp/install_tool

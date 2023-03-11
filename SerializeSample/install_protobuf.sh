#!/bin/sh

# bazelのインストール 
sudo apt install apt-transport-https curl gnupg -y
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update
sudo apt install bazel
sudo apt update && sudo apt full-upgrade
sudo ln -s /usr/bin/bazel-1.0.0 /usr/bin/bazel

# protocol buffersのインストール 
sudo apt-get install g++ git
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
git submodule update --init --recursive
sudo bazel build :protoc :protobuf
sudo cp bazel-bin/protoc /usr/local/bin

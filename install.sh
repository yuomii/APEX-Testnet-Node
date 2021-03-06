#!/bin/bash
echo "Add java repo"
sudo apt install software-properties-common -y
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt update -y
sudo apt install unzip -y
echo "Install java"
sudo apt install adoptopenjdk-12-hotspot -y
echo "Get gradle binary"
wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip
echo "Install gradle"
sudo rm -r ~/gradle
unzip -d ~/gradle gradle-4.10.2-bin.zip
sudo rm gradle-4.10.2-bin.zip
echo "Clone APEX Core"
git clone https://github.com/APEX-Network/APEX-Blockchain-Core.git
cd APEX-Blockchain-Core
git checkout master
echo "Build Core"
~/gradle/gradle-4.10.2/bin/gradle shadowJar
cd ..
cp APEX-Blockchain-Core/build/libs/APEX-Blockchain-Core-0.9.2.jar apex-blockchain-core.jar
echo "Clone APEX Client"
git clone https://github.com/APEX-Network/APEX-Blockchain-CLI.git
cd APEX-Blockchain-CLI
git checkout master
mkdir libs
cd ..
cp apex-blockchain-core.jar APEX-Blockchain-CLI/libs/APEX-Blockchain-Core-0.9.2.jar
cd APEX-Blockchain-CLI
echo "Build Client"
~/gradle/gradle-4.10.2/bin/gradle shadowJar
cd ..
cp APEX-Blockchain-CLI/build/libs/APEX-Blockchain-CLI-0.9.2.jar apex-blockchain-cli.jar
sudo chown -R $USER ~/APEX-Mainnet-Node
sudo chmod -R a+rw ~/APEX-Mainnet-Node
echo ""
echo "Installed APEX-Core and APEX-Cli successfully"
echo ""

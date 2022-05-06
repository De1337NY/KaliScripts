#! /bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

if [ ! -d "/home/transfer" ]; then
	mkdir "/home/transfer"
fi

if [ ! -d "/opt/SecLists" ]; then
	mkdir "/opt/SecLists"
fi

echo "[+] Dropping PimpMyKali in /home/kali..."
wget https://github.com/Dewalt-arch/pimpmykali/blob/be57a43127a53355454bb90033e6dec4d9075825/pimpmykali.sh -P /opt/
chmod +x /home/kali/pimpmykali.sh

echo "[+] Installing GoLang..."
sudo apt install -y golang
export PATH="$PATH:$HOME/go/bin"

echo "[+] Installing Assetfinder..."
go install -v github.com/tomnomnom/assetfinder@latest

echo "[+] Installing AMASS..."
go install -v github.com/OWASP/Amass/v3/...@master

echo "[+] Installing HTTProbe..."
go install -v github.com/tomnomnom/httprobe@latest

echo "[+] Installing GoWitness..."
go install -v github.com/sensepost/gowitness@latest

echo "[+] Dropping LinPeas in /home/transfer..."
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas_linux_amd64 -P /home/transfer/

echo "[+] Dropping WinPeas in /home/transfer..."
wget https://github.com/carlospolop/PEASS-ng/blob/585fcc33b20bc68763ed15bcf6b9d49c507aadc2/winPEAS/winPEASbat/winPEAS.bat -P /home/transfer

echo "[+] Dropping Powerview in /home/transfer..."
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -P /home/transfer

echo "[+] Installing Awesome-Nmap-Grep..."
sudo git clone https://github.com/leonjza/awesome-nmap-grep.git /opt/awesome-nmap-grep

echo "[+] Dropping SecLists in /opt/SecLists"
git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists

echo "[+] Starting PimpMyKali..."
./opt/pimpmykali.sh

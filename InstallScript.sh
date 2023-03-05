#! /bin/bash

#adding CoLoRs
red='\033[0;31m'
green='\033[0;32m'
purple='\033[0;35m'
nc='\033[0m' #no color

#start with Kali updates
echo -e "${green}[+]${purple}Updating Kali...${nc}"
sudo apt-get update -y
sudo apt-get upgrade -y

#checking for and creating transfer directory for webserver hosted files
if [ ! -d "/home/transfer" ]; then
	mkdir "/home/transfer"
fi

echo -e "${green}[+]${purple}Dropping PimpMyKali in /opt/pimpmykali..${nc}"
if [ ! -d "/opt/pimpmykali" ]; then
	mkdir "/opt/pimpmykali"
fi
git clone https://github.com/Dewalt-arch/pimpmykali.git /opt/pimpmykali

echo -e "${green}[+]${purple}Installing GoLang...${nc}"
sudo apt install -y golang
export PATH="$PATH:$HOME/go/bin"

echo -e "${green}[+]${purple}Installing Assetfinder...${nc}"
go install -v github.com/tomnomnom/assetfinder@latest

echo -e "${green}[+]${purple}Installing AMASS...${nc}"
go install -v github.com/OWASP/Amass/v3/...@master

echo -e "${green}[+]${purple}Installing HTTProbe...${nc}"
go install -v github.com/tomnomnom/httprobe@latest

echo -e "${green}[+]${purple}Installing GoWitness...${nc}"
go install -v github.com/sensepost/gowitness@latest

echo -e "${green}[+]${purple}Dropping LinPeas in /home/transfer...${nc}"
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas_linux_amd64 -P /home/transfer/

echo -e "${green}[+]${purple}Dropping WinPeas in /home/transfer...${nc}"
wget https://github.com/carlospolop/PEASS-ng/blob/585fcc33b20bc68763ed15bcf6b9d49c507aadc2/winPEAS/winPEASbat/winPEAS.bat -P /home/transfer

echo -e "${green}[+]${purple}Dropping Powerview in /home/transfer...${nc}"
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -P /home/transfer

echo -e "${green}[+]${purple}Installing Awesome-Nmap-Grep...${nc}"
sudo git clone https://github.com/leonjza/awesome-nmap-grep.git /opt/awesome-nmap-grep

echo -e "${green}[+]${purple}Dropping SecLists in /usr/share/wordlists${nc}"
git clone https://github.com/danielmiessler/SecLists.git /usr/share/wordlists

echo -e "${green}[+]${purple}Starting PimpMyKali...${nc}"
./opt/pimpmykali/pimpmykali.sh

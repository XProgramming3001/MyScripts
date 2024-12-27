#bin/bash

target=$1
api_key_shodan=$2


# verifions les paquets

echo 'verification en cours et installation si possible'

if which nmap && which shodan && which whois 
then 
echo 'tous les paquets sont deja installe'

else

apt install nmap
apt install whois
apt install shodan

shodan init $api_key_shodan
echo 'paquets installes avec sucess'
fi

echo "Starting reconnaissance on $target" 

# WHOIS lookup

whois $target > whois_info.txt 

echo "WHOIS lookup completed." 

# Nmap scan

nmap -sS -O -p 1-65535 $target -oN nmap_scan.txt 

echo "Nmap scan completed." 

# Shodan search

shodan search "hostname:$target" > shodan_info.txt 

echo "Shodan search completed." 

echo "Reconnaissance completed. Results stored in whois_info.txt, nmap_scan.txt, and shodan_info.txt" 

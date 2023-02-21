#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

function __get_github_release(){
    repo=$1
    filter=$2
    basedir=${3:-.}
    mkdir -p $basedir
    files=$(curl -s https://api.github.com/repos/$repo/releases/latest | grep browser_download_url | cut -d '"' -f 4 | grep -E "$filter")
    #echo $files
    for i in $files ; do
        wget --quiet  --no-check-certificate $i -O $basedir/$(basename $i)
    done
}

# Sysinternals Suite
#echo "Sysinternals Suite"
#mkdir -p SysinternalsSuite
#wget --quiet https://download.sysinternals.com/files/SysinternalsSuite.zip -O SysinternalsSuite.zip 
#unzip -o SysinternalsSuite.zip  -d ./SysinternalsSuite
#rm SysinternalsSuite.zip 

# nc
echo "nc"
wget --quiet https://github.com/int0x33/nc.exe/raw/master/nc64.exe -P nc -O nc64.exe
wget --quiet https://github.com/int0x33/nc.exe/raw/master/nc.exe -P nc -O nc.exe 

# chisel
echo "chisel"
__get_github_release jpillora/chisel 'windows_(386|amd64)'


# socat
echo "socat"
mkdir -p socat
wget --quiet http://blog.gentilkiwi.com/downloads/socat-1.7.2.1.zip -O socat-1.7.2.1.zip

# RogueWinRM
echo "RogueWinRM"
__get_github_release antonioCoco/RogueWinRM "zip"

# winPEAS
mkdir -p enum
echo "winPEAS"
__get_github_release carlospolop/PEASS-ng "/winPEAS"

# Seatbelt
echo "Seatbelt"
wget --quiet https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Seatbelt.exe -O Seatbelt.exe

# Snaffler
echo "Snaffler"
__get_github_release SnaffCon/Snaffler "exe"

# kerbrute
echo "Kerbrute"
__get_github_release ropnop/kerbrute "windows"

# LaZagne
echo "LaZagne"
__get_github_release AlessandroZ/LaZagne 'exe'

# mimikatz
echo "mimikatz"
__get_github_release gentilkiwi/mimikatz zip

# Rubeus https://github.com/GhostPack/Rubeus
wget --quiet https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe -O Rubeus.exe 


# sharpup 
echo "SharpUp"
wget --quiet https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/SharpUp.exe -O SharpUp.exe

# powerup https://github.com/PowerShellMafia/PowerSploit/tree/dev/Privesc

# PowerUpSQL 
echo "PowerUpSQL"
mkdir -p PowerUpSQL
exts=("psd1" "ps1" "psm1")
for ext in ${exts[@]} ; do
    wget --quiet https://raw.githubusercontent.com/NetSPI/PowerUpSQL/master/PowerUpSQL.$ext -O PowerUpSQL/PowerUpSQL.$ext #2> /dev/null
done

# PowerSpray
echo "PowerSpray"
mkdir -p PowerSpray
 wget --quiet https://raw.githubusercontent.com/n0tspam/SinglePowerSpray/main/SinglePowerSpray.ps1 -O PowerSpray/SinglePowerSpray.ps1  # 2> /dev/null
 wget --quiet https://raw.githubusercontent.com/n0tspam/SinglePowerSpray/main/SinglePowerSpray.psd1 -O PowerSpray/SinglePowerSpray.ps1  # 2> /dev/null

# Sharpview
echo "SharpView"
wget --quiet  https://github.com/tevora-threat/SharpView/raw/master/Compiled/SharpView.exe -O SharpView.exe


# Inveigh https://github.com/Kevin-Robertson/Inveigh
__get_github_release Kevin-Robertson/Inveigh "win"


# responder
#

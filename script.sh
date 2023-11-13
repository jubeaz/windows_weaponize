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
#    echo $files
    for i in $files ; do
        wget --quiet  --no-check-certificate $i -O $basedir/$(basename $i)
    done
}
mkdir -p bin
mkdir -p ps/empire

# Sysinternals Suite
#echo "Sysinternals Suite"
#mkdir -p ./bin/SysinternalsSuite
#wget --quiet https://download.sysinternals.com/files/SysinternalsSuite.zip -O SysinternalsSuite.zip 
#unzip -o SysinternalsSuite.zip  -d ./bin/SysinternalsSuite
#rm SysinternalsSuite.zip 


echo 'empire ps modules'
cp -r /usr/share/empire/empire/server/data/module_source/* ps/empire/

# nc
echo "nc"
wget --quiet https://github.com/int0x33/nc.exe/raw/master/nc64.exe -P nc -O bin/nc64.exe
wget --quiet https://github.com/int0x33/nc.exe/raw/master/nc.exe -P nc -O bin/nc.exe 

# chisel
echo "chisel"
__get_github_release jpillora/chisel 'windows_(386|amd64)'
mv chisel* bin


# socat
echo "socat"
wget --quiet http://blog.gentilkiwi.com/downloads/socat-1.7.2.1.zip -O bin/socat-1.7.2.1.zip

# RogueWinRM
echo "RogueWinRM"
__get_github_release antonioCoco/RogueWinRM "zip"
mv RogueWinRM.zip bin

# winPEAS
echo "winPEAS"
__get_github_release carlospolop/PEASS-ng "/winPEAS"
mv winPEAS* bin

## Seatbelt
#echo "Seatbelt"
#wget --quiet https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Seatbelt.exe -O Seatbelt.exe
#
## Snaffler
#echo "Snaffler"
#__get_github_release SnaffCon/Snaffler "exe"

# kerbrute
echo "Kerbrute"
__get_github_release ropnop/kerbrute "windows"
mv kerbrute* bin

# LaZagne
echo "LaZagne"
__get_github_release AlessandroZ/LaZagne 'exe'
mv LaZagne* bin


# mimikatz
echo "mimikatz"
__get_github_release gentilkiwi/mimikatz zip
mv mimikatz* bin

## Rubeus https://github.com/GhostPack/Rubeus
#echo "Rubeus"
#wget --quiet https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe -O Rubeus.exe 


## sharpup 
#echo "SharpUp"
#wget --quiet https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/SharpUp.exe -O SharpUp.exe

# powerup https://github.com/PowerShellMafia/PowerSploit/tree/dev/Privesc

# PowerUpSQL 
echo "PowerUpSQL"
mkdir -p ps/PowerUpSQL
exts=("psd1" "ps1" "psm1")
for ext in ${exts[@]} ; do
    wget --quiet https://raw.githubusercontent.com/NetSPI/PowerUpSQL/master/PowerUpSQL.$ext -O ps/PowerUpSQL/PowerUpSQL.$ext #2> /dev/null
done

# PowerSpray
echo "PowerSpray"
 wget --quiet https://raw.githubusercontent.com/n0tspam/SinglePowerSpray/main/SinglePowerSpray.ps1 -O ps//SinglePowerSpray.ps1  # 2> /dev/null

echo "Inveigh"
# Inveigh https://github.com/Kevin-Robertson/Inveigh
mkdir -p ps/Inveigh
exts=("psd1" "ps1" "psm1")
for ext in ${exts[@]} ; do
    wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh.$ext -O ps/Inveigh/Inveigh.$ext  # 2> /dev/null
done
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh-Relay.ps1 -O ps/Inveigh/Inveigh-Relay.ps1  # 2> /dev/null

echo 'Pretender'
__get_github_release RedTeamPentesting/pretender "Windows"
mv pretender* bin

# responder
# Sharpview
#echo "SharpView"
#wget --quiet  https://github.com/tevora-threat/SharpView/raw/master/Compiled/SharpView.exe -O SharpView.exe

# PingCastle
echo 'PingCastle'
__get_github_release vletoux/pingcastle "zip"
mv PingCastle* bin


echo 'EnableAllTokenPrivs'
wget --quiet https://raw.githubusercontent.com/fashionproof/EnableAllTokenPrivs/master/EnableAllTokenPrivs.ps1 -O ps/EnableAllTokenPrivs.ps1


echo 'nishang'
wget --quiet 'https://api.github.com/repos/samratashok/nishang/zipball/v0.7.6' -O ps/nishang.zip

echo 'ADRecon'
wget --quiet https://raw.githubusercontent.com/sense-of-security/ADRecon/master/ADRecon.ps1 -O ps/ADRecon.ps1

echo 'adPEAS'
wget --quiet https://raw.githubusercontent.com/61106960/adPEAS/main/adPEAS.ps1 -O ps/adPEAS.ps1

echo 'Get-SpoolStatus'
wget --quiet https://raw.githubusercontent.com/NotMedic/NetNTLMtoSilverTicket/master/Get-SpoolStatus.ps1 -O ps/Get-SpoolStatus.ps1

echo 'PetitPotam'
wget --quiet https://github.com/topotam/PetitPotam/raw/main/PetitPotam.exe -O bin/PetitPotam.exe

#echo 'powersploit'
#wget --quiet https://github.com/PowerShellMafia/PowerSploit/archive/refs/tags/v3.0.0.zip -O ps/powersploit.zip

echo 'SharpHound'
wget --quiet https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.ps1 -O ps/SharpHound.ps1

#echo 'PrivescCheck.ps1' =======> empire
#wget --quiet https://raw.githubusercontent.com/itm4n/PrivescCheck/master/PrivescCheck.ps1 -O ps/PrivescCheck.ps1

echo 'psgetsys.ps1'
wget --quiet https://raw.githubusercontent.com/decoder-it/psgetsystem/master/psgetsys.ps1 -O ps/psgetsys.ps1

echo 'PrintNightmare.ps1'
wget --quiet https://raw.githubusercontent.com/calebstewart/CVE-2021-1675/main/CVE-2021-1675.ps1 -O ps/PrintNightmare.ps1

echo 'Conjure-LSASS.ps1'
wget --quiet https://raw.githubusercontent.com/FuzzySecurity/PowerShell-Suite/master/Invoke-Runas.ps1 -O ps/Conj²ure-LSASS.ps1

echo 'jaws-enum.ps1'
wget --quiet https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1 -O ps/jaws-enum.ps1

echo 'Invoke-Clipboard.ps1'
wget --quiet https://raw.githubusercontent.com/inguardians/Invoke-Clipboard/master/Invoke-Clipboard.ps1 -O ps/Invoke-Clipboard.ps1


echo 'Invoke-StickyReader.ps1'
wget --quiet https://raw.githubusercontent.com/whitej3rry/StickyReader/master/Invoke-StickyReader.ps1 -O ps/Invoke-StickyReader.ps1


echo 'LAPSToolkit.ps1'
wget --quiet https://raw.githubusercontent.com/leoloobeek/LAPSToolkit/master/LAPSToolkit.ps1 -O ps/LAPSToolkit.ps1



echo 'Invoke-TheHash'

wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-SMBClient.ps1 -O ps/Invoke-SMBClient.ps1
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-SMBEnum.ps1 -O ps/Invoke-SMBEnum.ps1
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-SMBExec.ps1 -O ps/Invoke-SMBExec.ps1
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-TheHash.ps1 -O ps/Invoke-TheHash.ps1
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-TheHash.psd1 -O ps/Invoke-TheHash.psd1
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-TheHash.psm1 -O ps/Invoke-TheHahs.psm1
wget --quiet https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-WMIExec.ps1 -O ps/Invoke-WMIExec.ps1



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
        eget  --no-check-certificate $i -O $basedir/$(basename $i)
    done
}
mkdir -p bin
mkdir -p dll
mkdir -p ps/empire


# Sysinternals Suite
echo "Sysinternals Suite"
eget  https://download.sysinternals.com/files/SysinternalsSuite.zip  --all --upgrade-only --to ./bin/SysinternalsSuite


echo 'empire ps modules'
cp -r /usr/share/empire/empire/server/data/module_source/* ps/empire/

# nc
echo "nc"
eget  https://github.com/int0x33/nc.exe/raw/master/nc64.exe  --download-only --upgrade-only --to ./bin
eget  https://github.com/int0x33/nc.exe/raw/master/nc.exe  --download-only --upgrade-only --to ./bin


# chisel
echo "chisel"
eget jpillora/chisel -s windows/amd64 --download-only --upgrade-only --to ./bin
eget jpillora/chisel -s windows/386 --download-only  --upgrade-only --to ./bin

# socat
echo "socat"
eget http://blog.gentilkiwi.com/downloads/socat-1.7.2.1.zip  --download-only --upgrade-only --to ./bin

# printspoofer
echo "PrintSpoofer"
eget itm4n/PrintSpoofer -a 32.exe  --download-only  --upgrade-only --to ./bin
eget itm4n/PrintSpoofer -a 64.exe  --download-only  --upgrade-only --to ./bin

# godpotato
echo "GodPotato"
eget BeichenDream/GodPotato -a NET4.exe  --download-only  --upgrade-only --to ./bin
eget BeichenDream/GodPotato -a NET2.exe  --download-only  --upgrade-only --to ./bin
eget BeichenDream/GodPotato -a NET35.exe  --download-only  --upgrade-only --to ./bin

# roguepotato
echo "RoguePotato"
eget antonioCoco/RoguePotato -a Rogue  --download-only  --upgrade-only --to ./bin

# RogueWinRM
echo "RogueWinRM"
eget antonioCoco/RogueWinRM -a Rogue  --download-only  --upgrade-only --to ./bin

# winPEAS
echo "winPEAS"
eget peass-ng/PEASS-ng -a winPEAS.bat  --download-only  --upgrade-only --to ./ps
eget peass-ng/PEASS-ng -a winPEASx64.exe  --download-only  --upgrade-only --to ./bin
eget peass-ng/PEASS-ng -a winPEASx64_ofs.exe  --download-only  --upgrade-only --to ./bin
eget peass-ng/PEASS-ng -a winPEASx86.exe  --download-only  --upgrade-only --to ./bin
eget peass-ng/PEASS-ng -a winPEASx86_ofs.exe  --download-only  --upgrade-only --to ./bin

# kerbrute
echo "Kerbrute"
eget ropnop/kerbrute -s windows/amd64  --download-only  --upgrade-only --to ./bin
eget ropnop/kerbrute -s windows/386  --download-only  --upgrade-only --to ./bin

# LaZagne
echo "LaZagne"
eget AlessandroZ/LaZagne -a LaZagne  --download-only  --upgrade-only --to ./bin

# mimikatz
echo "mimikatz"
eget gentilkiwi/mimikatz -a zip  --download-only  --upgrade-only --to ./bin



## PowerUpSQL 
echo "PowerUpSQL"
mkdir -p ps/PowerUpSQL
exts=("psd1" "ps1" "psm1")
for ext in ${exts[@]} ; do
    eget https://raw.githubusercontent.com/NetSPI/PowerUpSQL/master/PowerUpSQL.$ext --download-only --upgrade-only --to ./ps #2> /dev/null
done

# PowerSpray
echo "PowerSpray"
 eget https://raw.githubusercontent.com/n0tspam/SinglePowerSpray/main/SinglePowerSpray.ps1 --download-only --upgrade-only --to ./ps  # 2> /dev/null

echo "Inveigh"
mkdir -p ps/Inveigh
exts=("psd1" "ps1" "psm1")
for ext in ${exts[@]} ; do
   eget https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh.$ext --download-only --upgrade-only --to ./ps/Inveigh
done

echo 'Pretender'
eget RedTeamPentesting/pretender -a Windows_x86_64 --download-only --upgrade-only --to ./bin

# PingCastle
echo 'PingCastle'
eget vletoux/pingcastle -a zip  --download-only  --upgrade-only --to ./bin
#
#
echo 'EnableAllTokenPrivs'
eget https://raw.githubusercontent.com/fashionproof/EnableAllTokenPrivs/master/EnableAllTokenPrivs.ps1 --download-only --upgrade-only --to ./ps

echo 'nishang'
eget 'https://github.com/samratashok/nishang/archive/refs/tags/v0.7.6.zip'  --download-only --upgrade-only --to ./ps/nishang-v0.7.6.zip

echo 'ADRecon'
eget https://raw.githubusercontent.com/sense-of-security/ADRecon/master/ADRecon.ps1 --download-only --upgrade-only --to ./ps

echo 'adPEAS'
eget https://raw.githubusercontent.com/61106960/adPEAS/main/adPEAS.ps1 --download-only --upgrade-only --to ./ps

echo 'Get-SpoolStatus'
eget https://raw.githubusercontent.com/NotMedic/NetNTLMtoSilverTicket/master/Get-SpoolStatus.ps1 --download-only --upgrade-only --to ./ps

echo 'PetitPotam'
eget https://github.com/topotam/PetitPotam/raw/main/PetitPotam.exe  --download-only --upgrade-only --to ./bin

echo 'SharpHound'
eget https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.ps1 --download-only --upgrade-only --to ./ps

echo 'psgetsys.ps1'
eget https://raw.githubusercontent.com/decoder-it/psgetsystem/master/psgetsys.ps1 --download-only --upgrade-only --to ./ps

echo 'PrintNightmare.ps1'
eget https://raw.githubusercontent.com/calebstewart/CVE-2021-1675/main/CVE-2021-1675.ps1 --download-only --upgrade-only --to ./ps

echo 'Conjure-LSASS.ps1'
eget https://raw.githubusercontent.com/FuzzySecurity/PowerShell-Suite/master/Invoke-Runas.ps1 --download-only --upgrade-only --to ./ps

echo 'jaws-enum.ps1'
eget https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1 --download-only --upgrade-only --to ./ps

echo 'Invoke-Clipboard.ps1'
eget https://raw.githubusercontent.com/inguardians/Invoke-Clipboard/master/Invoke-Clipboard.ps1 --download-only --upgrade-only --to ./ps


echo 'Invoke-StickyReader.ps1'
eget https://raw.githubusercontent.com/whitej3rry/StickyReader/master/Invoke-StickyReader.ps1 --download-only --upgrade-only --to ./ps


echo 'LAPSToolkit.ps1'
eget https://raw.githubusercontent.com/leoloobeek/LAPSToolkit/master/LAPSToolkit.ps1 --download-only --upgrade-only --to ./ps

echo 'Invoke-TheHash'
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-SMBClient.ps1 --download-only --upgrade-only --to ./ps
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-SMBEnum.ps1   --download-only --upgrade-only --to ./ps
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-SMBExec.ps1   --download-only --upgrade-only --to ./ps
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-TheHash.ps1   --download-only --upgrade-only --to ./ps
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-TheHash.psd1  --download-only --upgrade-only --to ./ps
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-TheHash.psm1  --download-only --upgrade-only --to ./ps
eget https://raw.githubusercontent.com/Kevin-Robertson/Invoke-TheHash/master/Invoke-WMIExec.ps1   --download-only --upgrade-only --to ./ps

echo 'AD ACL Scanner'
eget https://raw.githubusercontent.com/canix1/ADACLScanner/master/ADACLScan.ps1 --download-only --upgrade-only --to ./ps


echo 'Microsoft.ActiveDirectory.Management.dll'
eget https://raw.githubusercontent.com/samratashok/ADModule/master/Microsoft.ActiveDirectory.Management.dll --download-only --upgrade-only --to ./dll

echo 'Import-ActiveDirectory.ps1'
eget https://raw.githubusercontent.com/samratashok/ADModule/master/Import-ActiveDirectory.ps1 --download-only --upgrade-only --to ./ps

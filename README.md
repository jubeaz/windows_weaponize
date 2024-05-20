# windows_weaponize



# build impacket

## change ntlmrelayx
From [LuemmelSec/ntlmrelayx.py_to_exe](https://github.com/LuemmelSec/ntlmrelayx.py_to_exe)
### after import SOCKS
replace line:
```python
from impacket.examples.ntlmrelayx.servers.socksserver import SOCKS
```
with : 
```python
from impacket.examples.ntlmrelayx.servers.socksserver import SOCKS

from impacket.examples.ntlmrelayx.clients.dcsyncclient import DCSYNCRelayClient
from impacket.examples.ntlmrelayx.clients.httprelayclient import HTTPRelayClient,HTTPSRelayClient
from impacket.examples.ntlmrelayx.clients.rpcrelayclient import RPCRelayClient
from impacket.examples.ntlmrelayx.clients.smbrelayclient import SMBRelayClient
from impacket.examples.ntlmrelayx.clients.smtprelayclient import SMTPRelayClient
from impacket.examples.ntlmrelayx.clients.ldaprelayclient import LDAPRelayClient,LDAPSRelayClient
from impacket.examples.ntlmrelayx.clients.mssqlrelayclient import MSSQLRelayClient
from impacket.examples.ntlmrelayx.clients.imaprelayclient import IMAPRelayClient,IMAPSRelayClient
from impacket.examples.ntlmrelayx.attacks.dcsyncattack import DCSYNCAttack
from impacket.examples.ntlmrelayx.attacks.httpattack import HTTPAttack
from impacket.examples.ntlmrelayx.attacks.httpattacks import adcsattack
from impacket.examples.ntlmrelayx.attacks.ldapattack import LDAPAttack
from impacket.examples.ntlmrelayx.attacks.mssqlattack import MSSQLAttack
from impacket.examples.ntlmrelayx.attacks.smbattack import SMBAttack
from impacket.examples.ntlmrelayx.attacks.imapattack import IMAPAttack
from impacket.examples.ntlmrelayx.attacks.rpcattack import RPCAttack

PROTOCOL_ATTACKS = {"DCSYNC":DCSYNCAttack, "HTTP":HTTPAttack, "HTTPS":adcsattack ,"IMAP":IMAPAttack,"IMAPS":IMAPAttack,"SMB":SMBAttack,"RPC":RPCAttack,"MSSQL":MSSQLAttack,"LDAP":LDAPAttack, "LDAPS":LDAPAttack}
PROTOCOL_CLIENTS = {"DCSYNC":DCSYNCRelayClient, "HTTP":HTTPRelayClient, "HTTPS":HTTPSRelayClient, "SMTP":SMTPRelayClient, "LDAPS":LDAPSRelayClient, "IMAP":IMAPRelayClient, "IMAPS":IMAPSRelayClient, "SMB":SMBRelayClient,"RPC":RPCRelayClient,"MSSQL":MSSQLRelayClient,"LDAP":LDAPRelayClient}

RELAY_SERVERS = []
```

### loading of protocols
replace lines:
```python
    from impacket.examples.ntlmrelayx.clients import PROTOCOL_CLIENTS
    from impacket.examples.ntlmrelayx.attacks import PROTOCOL_ATTACKS
```
with:
```python
    for x in PROTOCOL_CLIENTS.keys():
        logging.info('Protocol Client %s loaded..' % x)
```

## build impacket

```
# choco install python3
choco install python38
$env:path+='c:\python38;'
$env:temp="c:\temp"
c:\python38\python.exe -m pip install pyinstaller
c:\python38\python.exe -m pip install --upgrade pyinstaller
git clone https://github.com/fortra/impacket.git -b master 
Set-Location <impacket-repo-path>
c:\python38\python.exe -m pip install .
c:\python38\python.exe setup.py  install
c:\python38\python.exe -m pip install dsinternals pyreadline uuid

Get-ChildItem "<impacket-repo-path>\examples" -Filter *.py |
Foreach-Object {
    C:\Python38\python.exe -m PyInstaller --path C:\Python38\Lib\site-packages\impacket,C:\Python38\Lib\site-packages,C:\Python38\Lib --hidden-import=impacket.examples.utils --specpath $env:temp\spec --workpath $env:temp\build --distpath $env:temp\out --clean -F $_.FullName
}
```


# build Reponder
responder is hardly linked to linux use pretender :)

settings.py:
```
		try:
			NetworkCard = subprocess.check_output(["ifconfig", "-a"])
		except:
			try:
				NetworkCard = subprocess.check_output(["ip", "address", "show"])
			except subprocess.CalledProcessError as ex:
				NetworkCard = "Error fetching Network Interfaces:", ex
				pass
		try:
			p = subprocess.Popen('resolvectl', stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
			DNS = p.stdout.read()
		except:
			p = subprocess.Popen(['cat', '/etc/resolv.conf'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
			DNS = p.stdout.read()

		try:
			RoutingInfo = subprocess.check_output(["netstat", "-rn"])
		except:
			try:
				RoutingInfo = subprocess.check_output(["ip", "route", "show"])
			except subprocess.CalledProcessError as ex:
				RoutingInfo = "Error fetching Routing information:", ex
				pass

```
## status
```
PS C:\temp\out> .\Responder.exe -I ALL -i 192.168.56.10
                                         __
  .----.-----.-----.-----.-----.-----.--|  |.-----.----.
  |   _|  -__|__ --|  _  |  _  |     |  _  ||  -__|   _|
  |__| |_____|_____|   __|_____|__|__|_____||_____|__|
                   |__|

           ←[1;33mNBT-NS, LLMNR & MDNS Responder 3.1.4.0←[0m

  To support this project:
  Github -> https://github.com/sponsors/lgandx
  Paypal  -> https://paypal.me/PythonResponder

  Author: Laurent Gaffie (laurent.gaffie@gmail.com)
  To kill this script hit CTRL-C

The system cannot find the path specified.
Traceback (most recent call last):
  File "settings.py", line 351, in populate
  File "subprocess.py", line 415, in check_output
  File "subprocess.py", line 493, in run
  File "subprocess.py", line 858, in __init__
  File "subprocess.py", line 1311, in _execute_child
FileNotFoundError: [WinError 2] The system cannot find the file specified

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "Responder.py", line 64, in <module>
  File "settings.py", line 354, in populate
  File "subprocess.py", line 415, in check_output
  File "subprocess.py", line 493, in run
  File "subprocess.py", line 858, in __init__
  File "subprocess.py", line 1311, in _execute_child
FileNotFoundError: [WinError 2] The system cannot find the file specified
[10896] Failed to execute script 'Responder' due to unhandled exception!
```


## doc
```
git clone https://github.com/lgandx/Responder.git
C:\Python38\python.exe -m pip install pycryptodome
$env:temp="c:\temp"
Set-Location <responder-repo-path>
(Get-Content Responder.py -Raw) -Replace "os.geteuid\(\) == 0","True" | Out-File -Force -Encoding Default Responder.py
(Get-Content settings.py -Raw) -Replace "os.path.dirname\(__file__\)","'.'" | Out-File -Force -Encoding Default settings.py
c:\python38\python.exe -m pip install -r ./requirements.txt


C:\Python38\python.exe -m PyInstaller --specpath $env:temp\spec --workpath $env:temp\build --distpath $env:temp\out --clean -F .\Responder.py
C:\Python38\python.exe -m PyInstaller --specpath $env:temp\spec --workpath $env:temp\build --distpath $env:temp\out --clean -F .\tools\MultiRelay.py
C:\Python38\python.exe -m PyInstaller --specpath $env:temp\spec --workpath $env:temp\build --distpath $env:temp\out --clean -F .\tools\RunFinger.py
```
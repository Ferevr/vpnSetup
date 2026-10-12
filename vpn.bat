@echo off

:: check if vagrand and virtual box are installed
reg query "HKLM\SOFTWARE\Oracle\VirtualBox" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] VirtualBox esta instalado.
) else (
    echo [!] VirtualBox NO esta instalado.
    echo Procediento con la instalacion de VirtualBox
    ::download
    curl https://download.virtualbox.org/virtualbox/7.2.20/VirtualBox-7.2.20-175154-Win.exe --output virtualbox.exe

    ::install
    start /wait "" virtualbox.exe --silent --path "C:\Program Data\VirtualBox"
)

if exist "C:\Program Files\Vagrant\bin\vagrant.exe" (
    echo [OK] Vagrant instalado.
) else (
    echo [!] Vagrant no instalado.
    echo Procediendo con la instalacion de vagrant...

    ::download
    curl https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_windows_amd64.msi --output vagrant.msi

    ::install
    msiexec /package vagrant.msi /passive /norestart 
)



::download VM file
curl https://raw.githubusercontent.com/Ferevr/vpnSetup/refs/heads/main/Vagrantfile --output Vagrantfile
set /p "TAILSCALE_ROUTES=INTRODUCE LAS SUBREDES EN CIDR A LAS QUE QUIERES TENER ACCESO (SEPARADAS POR COMAS Y SIN ESPACIOS): "

vagrant up
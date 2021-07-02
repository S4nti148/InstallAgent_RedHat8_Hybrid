#!/bin/bash

#Script para instalar agente en RedHat
echo "Validando salida a repositorio de mono" 
if ping -c1 download.mono-project.com #&>/dev/null;
then

echo Validacion exitosa a repositorio
echo "Creando directorios" 
echo "--------------------------------"
cd /opt/
mkdir cylance
cd cylance
echo "Creando archivo de configuracion"
echo "--------------------------------"
echo "¿Cual es el Token a usar?"
read Token
echo "InstallToken=$Token" > config_defaults.txt
echo "¿Cual es el FQDN a usar?"
read FQDN 
echo "InstallRegistrationURL=https://$FQDN" >> config_defaults.txt
echo "InstallTrustedSuffix=$FQDN" >> config_defaults.txt
echo "InstallIndinityURL=https://$FQDN" >> config_defaults.txt
echo "Archivo de configuracion creado"
echo "---------------------------------"

echo "Instalando requisitos"
echo "-----------------------------------"


rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"  && 
su -c 'curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/monocentos8-stable.repo'

echo "---------------------"
echo "Instalando mono-devel"
echo "---------------------"

yum install -y mono-devel 
echo "--------Mono instalado------------"

echo "¿Cual es la ruta del certificado y del agente?"
read ruta
cd $ruta

echo "¿Como se llama el certificado?"
read certificado
cert-sync $certificado 

echo "¿Como se llama el agente?"
read agente
rpm -ivh $agente

echo "----------Listo-------------------"
else 
echo "No cuentas con salida a internet";
fi


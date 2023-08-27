#!/bin/bash
installDirectory=~/Library/Developer/Xcode/Templates

viperDirectory="Templates/File Template/VIPER"
testsDirectory="Templates/File Template/Tests"
mvvmDirectory="Templates/File Template/MVVM"
commonServicesDirectory="Templates/File Template/Common Services"
toolsDirectory="Templates/File Template/Tools"

mkdir -p "${installDirectory}"

cp -R "${viperDirectory}" "${installDirectory}/VIPER/"
cp -R "${testsDirectory}" "${installDirectory}/Tests/"
cp -R "${mvvmDirectory}" "${installDirectory}/MVVM/"
cp -R "${commonServicesDirectory}" "${installDirectory}/Core/"
cp -R "${toolsDirectory}" "${installDirectory}/Tools/"

echo "✅ Templates installed to ${installDirectory}"

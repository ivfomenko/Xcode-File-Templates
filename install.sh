#!/bin/bash

while getopts ":aetomv" OPT; do
  case $OPT in
    a)
      INSTALL_ALL="YES"
      ;;
    e)
      INSTALL_EXTENSIONS="YES"
      ;;
    t)
      INSTALL_TESTS="YES"
      ;;
    o)
      INSTALL_TOOLS="YES"
      ;;
    m) 
      INSTALL_MVVM="YES"
      ;;
    v)
      INSTALL_VIP="YES"
      ;;
    \?)
      echo "Invalid usage. Allowed options are -a, -e, -t, -o, -m, -v."
      exit 1
      ;;
  esac
done

installDirectory=~/Library/Developer/Xcode/Templates

mkdir -p "${installDirectory}"

if [ -n "$INSTALL_ALL" ]; then
    baseDir="Templates/File Template"
    cp -R "${baseDir}" "${installDirectory}"
    echo "✅ All templates installed to ${installDirectory}"
    exit 0
fi

if [ -n "$INSTALL_EXTENSIONS" ]; then
    baseDir="Templates/File Template/Extensions"
    cp -R "${baseDir}" "${installDirectory}/Extensions/"
    echo "✅ Extensions templates installed to ${installDirectory}/Extensions"
fi

if [ -n "$INSTALL_TESTS" ]; then
    baseDir="Templates/File Template/Tests"
    cp -R "${baseDir}" "${installDirectory}/Tests/"
    echo "✅ Test templates installed to ${installDirectory}/Extensions"
fi

if [ -n "$INSTALL_TOOLS" ]; then
    baseDir="Templates/File Template/Tools"
    cp -R "${baseDir}" "${installDirectory}/Tools/"
    echo "✅ Non-Swift templates installed to ${installDirectory}/Tools"
fi

if [ -n "$INSTALL_MVVM" ]; then
    baseDir="Templates/File Template/MVVM"
    cp -R "${baseDir}" "${installDirectory}/MVVM/"
    echo "✅ MVVM templates installed to ${installDirectory}/MVVM"
fi

if [ -n "$INSTALL_VIP" ]; then
    baseDir="Templates/File Template/VIPER"
    cp -R "${baseDir}" "${installDirectory}/VIPER/"
    echo "✅ VIPER templates installed to ${installDirectory}/VIPER"
fi

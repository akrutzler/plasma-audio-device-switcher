#!/bin/bash

cd package

version=$(sed -n 's/^X-KDE-PluginInfo-Version=//p' metadata.desktop)
zip -R "../audio-device-switcher-v$version.plasmoid" '*.qml' '*.desktop' '*.xml'

cd ..

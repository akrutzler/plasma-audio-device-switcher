/*
    Copyright 2017 Andreas Krutzler <andreas.krutzler@gmx.net>

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of
    the License or (at your option) version 3 or any later version
    accepted by the membership of KDE e.V. (or its successor approved
    by the membership of KDE e.V.), which shall act as a proxy
    defined in Section 14 of version 3 of the license.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2 as QtControls

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

// plasma pulseaudio plugin
import org.kde.plasma.private.volume 0.1

Item {
    id: main

    Layout.minimumWidth: gridLayout.implicitWidth
    Layout.minimumHeight: gridLayout.implicitHeight
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    property int labeling: plasmoid.configuration.labeling
    property bool useVerticalLayout: plasmoid.configuration.useVerticalLayout
    property bool usePortDescription: plasmoid.configuration.usePortDescription

    // from plasma-volume-control applet
    // see https://github.com/KDE/plasma-pa/blob/master/applet/contents/code/icon.js
    function formFactorIcon(formFactor) {
        switch(formFactor) {
            case "internal":
                return "audio-card";
            case "speaker":
                return "audio-speakers-symbolic";
            case "phone":
                return "phone";
            case "handset":
                return "phone";
            case "tv":
                return "video-television";
            case "webcam":
                return "camera-web";
            case "microphone":
                return "audio-input-microphone";
            case "headset":
                return "audio-headset";
            case "headphone":
                return "audio-headphones";
            case "hands-free":
                return "hands-free";
            case "car":
                return "car";
            case "hifi":
                return "hifi";
            case "computer":
                return "computer";
            case "portable":
                return "portable";
        }
        return "audio-volume-high"; // fallback
    }
    
    GridLayout {
        id: gridLayout
        flow: useVerticalLayout? GridLayout.TopToBottom : GridLayout.LeftToRight
        anchors.fill: parent

        QtControls.ExclusiveGroup {
            id: buttonGroup
        }

        Repeater {
            model: SinkModel {
            }

            delegate: PlasmaComponents.Button {
                id: tab
                enabled: currentPort !== null

                text: labeling != 2 ? currentDescription : ""
                iconName: labeling != 1 ? formFactorIcon(sink.formFactor) : ""

                checkable: true
                exclusiveGroup: buttonGroup
                tooltip: currentDescription

                Layout.fillWidth: true
                Layout.preferredWidth: -1

                readonly property var sink: model.PulseObject
                readonly property var currentPort: model.Ports[ActivePortIndex]
                readonly property string currentDescription: usePortDescription? currentPort ? currentPort.description : model.Description : model.Description
                
                Binding {
                    target: tab
                    property: "checked"
                    value: sink.default
                }

                onClicked: {
                    sink.default = true
                }
            }
        }
    }
}

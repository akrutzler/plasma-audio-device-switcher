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

    property bool showIconsOnly: plasmoid.configuration.showIconsOnly
    property bool useVerticalLayout: plasmoid.configuration.useVerticalLayout

    // from plasma-volume-control applet
    function iconNameFromPort(port, fallback) {
        if (port) {
            if (port.name.indexOf("speaker") !== -1) {
                return "audio-speakers-symbolic";
            } else if (port.name.indexOf("headphones") !== -1) {
                return "audio-headphones";
            } else if (port.name.indexOf("hdmi") !== -1) {
                return "video-television";
            } else if (port.name.indexOf("mic") !== -1) {
                return "audio-input-microphone";
            } else if (port.name.indexOf("phone") !== -1) {
                return "phone";
            }
        }
        return fallback;
    }

    GridLayout {
        id: gridLayout
        flow: useVerticalLayout == true ? GridLayout.TopToBottom : GridLayout.LeftToRight
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

                text: showIconsOnly ? "" : currentDescription
                iconName: showIconsOnly ? iconNameFromPort(currentPort, IconName) : ""

                checkable: true
                exclusiveGroup: buttonGroup
                tooltip: currentDescription

                Layout.fillWidth: true
                Layout.preferredWidth: showIconsOnly ? -1 : units.gridUnit * 10

                readonly property var sink: PulseObject
                readonly property var currentPort: Ports[ActivePortIndex]
                readonly property string currentDescription: currentPort ? currentPort.description : Description

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

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

import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0

Item {
    property int cfg_labeling: 0
    property alias cfg_usePortDescription: usePortDescription.checked
    property alias cfg_useVerticalLayout: useVerticalLayout.checked

    ColumnLayout {
        Layout.fillWidth: true
        
        ColumnLayout {
            id: labeling
            ExclusiveGroup { id: labelingGroup }
            Repeater {
                id: buttonRepeater
                model: [
                    i18n("Show icon with description"),
                    i18n("Show description only"),
                    i18n("Show icon only")
                ]
                RadioButton {
                    text: modelData
                    checked: index === cfg_labeling
                    exclusiveGroup: labelingGroup
                    onClicked: {
                        cfg_labeling = index
                    }
                }
            }
        }
        
        CheckBox {
            id: usePortDescription
            enabled: cfg_labeling != 2 // "Icon only"
            text: i18n("Use the audio sink's port description rather than the sink description")
        }
        CheckBox {
            id: useVerticalLayout
            text: i18n("Use vertical layout")
        }
    }
}



/*
QuickHub ControlCenter - www.quickhub.org
Copyright (C) 2021 Friedemann Metzger - mail (at) friedemann-metzger.de

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QuickHub 1.0
import QtQuick.Controls.Material 2.1

import "Users"
import "Devices"
import "ResourceTest"

ApplicationWindow {
    visible: true
    width: 600
    height: 700

    Material.accent: Material.DeepOrange

    TabBar {
        id: bar
        width: parent.width
        background: Rectangle {
            color: "grey"
            opacity: .1
        }

        TabButton {
            text: qsTr("Login")
        }

        TabButton {
            enabled: Connection.state == Connection.STATE_Authenticated
            text: qsTr("Users")
        }

        TabButton {
            text: qsTr("Lists")
            enabled: Connection.state == Connection.STATE_Authenticated
        }

        TabButton {
            text: qsTr("Objects")
            enabled: Connection.state == Connection.STATE_Authenticated
        }

        TabButton {
            text: qsTr("Services")
            enabled: Connection.state == Connection.STATE_Authenticated
        }

        TabButton {
            text: qsTr("Devices")
            enabled: Connection.state == Connection.STATE_Authenticated
        }
    }

    StackLayout {
        anchors.fill: parent
        width: parent.width
        currentIndex: bar.currentIndex

        Login {}
        Users {}
        ListResources {}
        ObjectResources {}
        Services {}
        Devices {}
    }

    footer: Item {
        height: 20
        Rectangle {
            height: 1
            width: parent.width
            color: "grey"
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 4
            text: {
                switch (Connection.state) {
                case Connection.STATE_Authenticating:
                    "Authenticating"
                    break
                case Connection.STATE_Authenticated:
                    "Authenticated"
                    break
                case Connection.STATE_Disconnected:
                    "Disconnected"
                    break
                case Connection.STATE_Connecting:
                    "Connecting"
                    break
                case Connection.STATE_Connected:
                    "Connected"
                    break
                }
            }
        }
    }

    function stateChanged() {
        console.log(Connection.state)
        if (Connection.state == Connection.STATE_Connected) {
            console.log("CONNECTED")
        }
    }
}

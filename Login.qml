

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
import QtQuick 2.0
import QuickHub 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "."

Item {
    id: docroot

    property bool connected: Connection.state == Connection.STATE_Connected
                             | Connection.state == Connection.STATE_Authenticated

    Column {
        anchors.centerIn: parent
        spacing: 10

        Timer {
            id: reconnectTimer
            interval: 1000
            repeat: true
            onTriggered: Connection.reconnectServer()
            running: Connection.state == Connection.STATE_Disconnected
        }

        Label {
            font.pixelSize: 20
            text: "Connect"
        }

        TextField {
            id: urlField
            width: 200
            placeholderText: "Server-URL"
            text: "ws://localhost:4711"
            onAccepted: Connection.serverUrl = text
        }

        Button {
            text: docroot.connected ? "Reconnect" : "Connect"
            onClicked: {
                if (Connection.serverUrl != urlField.text)
                    Connection.serverUrl = urlField.text
                else
                    Connection.reconnectServer()
            }
        }

        Item {
            height: 20
            width: 2
        }

        Label {
            font.pixelSize: 20
            text: "Login"
        }

        TextField {
            id: userId
            enabled: Connection.state == Connection.STATE_Connected
            text: "admin"
            width: 200
            placeholderText: "User ID"
        }

        TextField {
            id: passField
            width: 200
            echoMode: TextInput.Password
            placeholderText: "Password"
            enabled: Connection.state == Connection.STATE_Connected
            onAccepted: QuickHub.login(userId.text, passField.text,
                                       loginButton.loginCallback)
        }

        Button {
            id: loginButton
            text: Connection.state == Connection.STATE_Authenticated ? "Logout" : "Login"
            enabled: Connection.state >= Connection.STATE_Connected
            onClicked: {
                if (Connection.state == Connection.STATE_Connected) {
                    UserLogin.login(userId.text, passField.text, loginCallback)
                    Connection.keepaliveInterval = 3000
                } else
                    UserLogin.logout()
            }

            function loginCallback(login) {
                if (!login) {
                    passField.text = ""
                }
            }
        }
    }
}

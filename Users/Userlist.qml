

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
import QtQuick.Controls 2.0
import QuickHub 1.0
import QtQuick.Layouts 1.1
import "../Assets"
import "../Controls"

ListView {
    id: docroot
    Layout.fillHeight: true
    Layout.fillWidth: true
    property var currentPermissions
    signal deleteUser(string userID)
    signal editUser(string userID)
    signal setPermissions(string userID, var permissions)
    delegate: ItemDelegate {
        id: userDelegate
        width: parent.width
        height: 40
        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 0

            Item {
                width: 40
                height: parent.height
                Icon {
                    id: icon
                    property var permissions: userPermissions
                    icon: permissions["isAdmin"] == true ? Icons.admin : Icons.user
                    anchors.centerIn: parent
                }
            }

            Label {
                Layout.fillHeight: true
                verticalAlignment: Text.AlignVCenter
                Layout.maximumWidth: 180
                Layout.minimumWidth: 180
                text: userID + (sessionCount > 0 ? "<font color=\"grey\"> ["
                                                   + sessionCount + "]</font>" : "")
            }

            Label {
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.maximumWidth: 180
                Layout.minimumWidth: 180
                text: userName
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            SmallIconButton {
                onClicked: {
                    docroot.setPermissions(userID, icon.permissions)
                    docroot.currentPermissions = Qt.binding(function () {
                        return icon.permissions
                    })
                }
                visible: true
                icon: Icons.admin
            }

            SmallIconButton {
                onClicked: docroot.editUser(userID)
                visible: true
                icon: Icons.edit
            }

            SmallIconButton {
                onClicked: docroot.deleteUser(userID)
                visible: true
                icon: Icons.remove
            }
        }
    }
}

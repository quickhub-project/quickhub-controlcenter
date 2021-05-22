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
import QtQuick.Controls 2.2
import QuickHub 1.0
import QtQuick.Layouts 1.1


Dialog
{
    id: dialog
    title: "Change User Permissions"

    property string userID
    property var permissions
    property var permissionModel:[]

    onPermissionsChanged:
    {
        var model = []
        for (var k in permissions)
        {
            model.push({"perm":k, "val": permissions[k]})
        }
        permissionModel = model

    }

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width:300
    height: 500

    function setPermissionCallback(success, code)
    {
    }

    Timer
    {
        id:timer
        interval: 1500
        onTriggered: dialog.close()
    }

    ColumnLayout
    {
        spacing: 10
        anchors.fill: parent
        RowLayout
        {
            TextField
            {
                id: tagField
                Layout.fillWidth: true
                placeholderText: "Permission Tag"
                onAccepted:
                {
                    QuickHub.setPermission(userID, text, true, setPermissionCallback)
                    tagField.text = ""
                }
            }

            Button
            {
                text:"Add"
                onClicked:
                {
                    QuickHub.setPermission(userID, tagField.text, true, setPermissionCallback)
                    tagField.text = ""
                }
            }
        }

        ListView
        {
            model: permissionModel
            clip:true
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate:
            ItemDelegate
            {
                width: parent.width
                RowLayout
                {
                    width: parent.width
                    height: parent.height
                    spacing: 0

                    Label
                    {
                        Layout.fillHeight: true
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        text: modelData.perm
                    }
                    CheckBox
                    {
                        checked: modelData.val
                        onClicked: QuickHub.setPermission(userID, modelData.perm, checked, setPermissionCallback)
                    }
                }
            }
        }

        Row
        {
            Button
            {
                highlighted: true
                text:"OK"
                flat:true
                onClicked: dialog.close()
            }
        }
    }
}

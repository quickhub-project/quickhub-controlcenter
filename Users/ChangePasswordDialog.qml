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
    title: "Change password"
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width:300
    height: 300


    ColumnLayout
    {
        spacing: 10
        anchors.fill: parent

        TextField
        {
            id: oldpass
            placeholderText: "old Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
            onTextChanged: changePasswordStatus.text = ""
        }

        TextField
        {
            id: newPass
            placeholderText: "new Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
        }

        TextField
        {
            id: newPass2
            placeholderText: "repeat new Password"
            echoMode: TextInput.Password
            Layout.fillWidth: true
        }

        Label
        {
            id: changePasswordStatus
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignRight
            text:" "
        }

        Button
        {
            flat: true
            text: "Change Password"
            enabled: newPass.text == newPass2.text && newPass.text != ""
            onClicked: QuickHub.changePassword(oldpass.text, newPass.text, changePwCallback)
            function changePwCallback(success, code)
            {
                if(code === QuickHub.PermissionDenied)
                {
                    changePasswordStatus.text="Access Denied!";
                }

                if(code === QuickHub.IncorrectPassword)
                {
                    changePasswordStatus.text="Wrong password!";
                    oldpass.forceActiveFocus()
                    oldpass.text = ""
                }

                if(code === QuickHub.NoError)
                {
                    changePasswordStatus.text="Success!";
                    newPass.text = ""
                    newPass2.text = ""
                    oldpass.text = ""
                    userIdTextField.text = ""
                }
            }

        }
    }
}

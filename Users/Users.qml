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

Item
{
    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 20
        anchors.topMargin: 60
        spacing: 0


        function dleleteUserallback(success, code)
        {
            if(code == QuickHub.PermissionDenied)
            {
                deleteUserStatus.text="Access Denied!";
            }

            if(code == QuickHub.IncorrectPassword)
            {
                deleteUserStatus.text="Wrong password!";
            }

            if(code == QuickHub.NoError)
            {
                deleteUserStatus.text="Success!";
                deleteUserId.text = ""
                deletePassword.text = ""
            }

            if(code == QuickHub.UserNotExists)
            {
                deleteUserStatus.text="Unknown User!";
            }
        }

        Item
        {
           height:40
           opacity: .5
           Layout.fillWidth: true
           Row
           {
               anchors.bottom: parent.bottom
               anchors.bottomMargin: 2
               anchors.left: parent.left

               Item
               {
                    width: 40
                    height: parent.height
               }
               Label
               {
                   width: 180
                   text: "ID"
                   font.weight: Font.Bold
               }

               Label
               {
                   width: 180
                   text: "Name"
                   font.weight: Font.Bold
               }
//               Text
//               {
//                   horizontalAlignment: Text.AlignHCenter
//                   width: 40
//                   text: "Online"
//                   font.weight: Font.Bold
//               }
           }

            Rectangle
            {
                color:"black"
                width: parent.width
                anchors.bottom: parent.bottom
                height: 1
                opacity: .5

            }
        }

        UserListModel
        {
            id: userModel

        }

        Userlist
        {
            id: list

            flickDeceleration: 0
            model: userModel
            onDeleteUser:deleteUserDialog.deleteUser(userID)
            onEditUser: changePasswordDialog.open()
            onSetPermissions:
            {
                permissionDialog.userID = userID
                permissionDialog.open()
            }
        }

        Button
        {
            text:"Add User"
            flat: true
            highlighted: true
            onClicked: addUserdialog.open()
        }
    }

    AddUserDialog
    {
        id: addUserdialog
    }

    ChangePasswordDialog
    {
        id: changePasswordDialog
    }
    DeleteUserDialog
    {
        id: deleteUserDialog
    }
    ChangePermissionDialog
    {
        id: permissionDialog
        permissions: list.currentPermissions
    }
}


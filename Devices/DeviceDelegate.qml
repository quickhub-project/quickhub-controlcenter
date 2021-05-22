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
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.1
import QuickHub 1.0
import "../Assets"
import "../Controls"

ItemDelegate
{
    id: docroot

    property DeviceModel    deviceModel
    property string         _text: deviceModel.description != "" ? deviceModel.description : deviceModel.uuid
    property string         _type: deviceModel.type
    property string         _icon: deviceModel.deviceOnline ? Icons.online : Icons.offline
    property var            _properties
    default property alias  content: row.children

    clip:true
    opacity: deviceModel.deviceOnline ? 1 : 0.5

    Rectangle
    {
        anchors.fill: parent
        color:"black"
        opacity: .05
    }

    height: 65
    Layout.fillWidth: true

    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 10

        Label
        {
            color: Material.accent
            Layout.fillWidth: true
            text: docroot._text
            font.pixelSize: 18
        }

        Label
        {
            color: "grey"
            Layout.fillWidth: true
            text:docroot._type
            font.pixelSize: 12
        }

        Item{Layout.fillHeight: true; Layout.fillWidth: true}
    }



    Icon
    {
        id: icon
        icon: docroot._icon
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 20
        iconSize: 20
        width: 20
        height: 20
    }

    Row
    {
        anchors.rightMargin: 10
        visible: docroot.hovered
        id: row
        height: 40
        anchors.right: icon.left
        anchors.verticalCenter: parent.verticalCenter
    }
}

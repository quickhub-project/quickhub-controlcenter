

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
import "../Controls"
import "../Assets"

Item {
    id: docroot
    width: parent.width
    height: 40

    property bool hovered
    property var property
    property alias name: nameLabel.text
    property alias value: valueLabel.text

    signal editClicked
    signal settingsClicked
    default property alias content: row.children
    property bool transferring

    Label {
        id: nameLabel
        width: 130
        anchors.left: parent.left
        anchors.leftMargin: 0
        horizontalAlignment: Text.AlignRight
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: Text.Wrap
        text: property.name
        color: "grey"
    }

    Label {
        id: valueLabel
        x: 140
        anchors.verticalCenter: parent.verticalCenter
        text: property.value + " " + property.unitString
    }

    Icon {
        id: transferring
        anchors.left: valueLabel.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        icon: Icons.bidirectionalArrows
        visible: docroot.transferring
    }

    Row {
        id: row
        height: 40
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        visible: true //docroot.hovered
    }
}

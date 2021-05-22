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

import QuickHub 1.0
import QtQuick 2.14
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import "../Assets"
import "../Controls"


Item
{
    SynchronizedListModel
    {
        id: listModel
    }

    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 20
        anchors.topMargin: 60
        RowLayout
        {
            width: parent.width
            TextField
            {
                id: resourceField
                Layout.fillWidth: true
                onAccepted: listModel.resource = text
                placeholderText:"Resource ID"
            }
            Button
            {
                text: "Open"

                onClicked: listModel.resource = resourceField.text
            }
        }

        TableView
        {
            id: table
            Layout.fillHeight: true
            Layout.fillWidth: true
            columnSpacing: 0
            rowSpacing: 1
            clip: true

            model:listModel

            delegate:
            Item
            {
                implicitWidth: text.width+20
                implicitHeight: 30
                Rectangle
                {
                    anchors.right: parent.right
                    height: parent.height
                    visible: column != table.columns - 1
                    width: 1
                    color:"grey"
                    opacity: .2
                }

                Rectangle
                {
                    anchors.right: parent.right
                    height: 1
                    width: parent.width
                    color:"grey"
                }

                Text
                {
                    id: text
                    x: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: display
                }
            }
        }
    }
}

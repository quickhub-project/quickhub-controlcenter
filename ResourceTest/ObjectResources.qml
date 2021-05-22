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

import QtQuick 2.14
import QtQuick.Layouts 1.1
import QuickHub 1.0
import QtQuick.Controls 2.0

import "../Assets"
import "../Controls"

Item
{
    SynchronizedObjectModel
    {
        id: objectModel
    }

    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 20
        anchors.topMargin: 60

        RowLayout
        {
            TextField
            {
                id: idField
                placeholderText: "Resource ID"
                Layout.fillWidth: true
                onAccepted: objectModel.resource = text
            }

            Button
            {
                text:"Open"
                onClicked: objectModel.resource = text
            }

        }



        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true

            clip: true

            model:objectModel.keyValues

            delegate: Item
            {
                width: parent.width
                height: 40


                Label
                {
                    id: nameLabel
                    width: idField.width/2-5
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    horizontalAlignment: Text.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData
                    color: "grey"
                }

                Label
                {
                    id: valueLabel
                    anchors.left: nameLabel.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: objectModel[modelData]
                }
            }
        }

        RowLayout
                    {
                        opacity:  objectModel.connected ? 1 : 0
                        visible: opacity > 0
                        Behavior on opacity {NumberAnimation{}}
                        width: parent.width
                        spacing: 10

                        TextField
                        {
                            Layout.fillWidth: true
                            id: prop
                            placeholderText: "Property"
                        }

                        TextField
                        {
                            Layout.fillWidth: true
                            id: value
                            placeholderText: "Value"
                        }

                        Button
                        {
                            text:"Add"
                            onClicked: objectModel.setProperty(prop.text, value.text);
                        }
                    }
    }
}

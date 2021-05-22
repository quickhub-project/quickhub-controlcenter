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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import "../Controls"

Dialog
{
    id: docroot

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    property alias text: textInput.text
    signal trigger(var arg)

    standardButtons:  Dialog.Cancel
    width: 300

    Column
    {
        id: column
        width: parent.width


        TextField
        {
            width: parent.width
            placeholderText: "Property value"
            id: valInput
        }

        Item
        {
            height: 10
            width: parent.width
        }

        Button
        {
            anchors.right: parent.right
            text: "Send"
            onClicked: docroot.trigger(JSON.parse("{\"val\":"+valInput.text+"}"))
        }

        Item
        {
            height: 25
            width: parent.width
        }

        Label
        {
            text: "JSON Argument:"
        }

        Item
        {
            height: 10
            width: parent.width
        }

        TextInput
        {
            id: textInput
            width: parent.width
            height: 100

            Rectangle
            {
                anchors.fill: parent
                color: "black"
                opacity: .05
            }
        }

        Item
        {
            height: 10
            width: parent.width
        }

        Button
        {
            anchors.right: parent.right
            text: "Send"
            onClicked: docroot.trigger(JSON.parse(textInput.text))
        }
    }
}

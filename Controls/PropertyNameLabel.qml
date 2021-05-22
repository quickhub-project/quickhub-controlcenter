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
import "../Assets"

Item
{
    id: docroot

    property string     name
    property var        value

    width: layout.width
    height: layout.height

    Row
    {
        id: layout

        Label
        {
            id: label
            text: docroot.name+":"
        }

        Icon
        {
            id: icon

            visible: false
            anchors.verticalCenter: parent.verticalCenter
        }

        Label
        {
            id: value
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.verticalCenterOffset: 1
            text: docroot.value
        }

        Rectangle
        {
            id: colorRect
            visible: false
            width: 12
            height: 12
            radius: 6
            anchors.verticalCenter: parent.verticalCenter
        }

        states:
        [
            State
            {
                when: docroot.name == "on"

                PropertyChanges
                {
                    target: label
                    visible: false
                }

                PropertyChanges
                {
                    target: icon
                    icon: Icons.on
                    visible: true
                }
            },
            State
            {
                PropertyChanges
                {
                    target: label
                    visible: false
                }

                PropertyChanges
                {
                    target: value
                    visible: false
                }

                when: docroot.name == "color"
                PropertyChanges
                {
                    target: icon
                    icon: Icons.brush
                    visible: true
                }

                PropertyChanges
                {
                    target: colorRect
                    color: docroot.value
                    visible: true
                }
            },
            State
            {
                PropertyChanges
                {
                    target: label
                    visible: false
                }

                when: docroot.name == "temperature"
                PropertyChanges
                {
                    target: icon
                    icon: Icons.temp
                    visible: true
                }
            }
        ]
    }
}

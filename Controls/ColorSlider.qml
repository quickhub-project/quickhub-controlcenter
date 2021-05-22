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

Slider
{
    id: mySlider
    height: 40
    live:false
    from:0
    to:1
    signal colorChanged(color color)

    property color currentColor: Qt.hsva(value,1,1)
    function setColor(color)
    {
        currentColor = color
        mySlider.value = currentColor.hsvHue
    }

    handle:
    Rectangle
    {
        x: mySlider.leftPadding + mySlider.visualPosition * (mySlider.availableWidth - width)
        y: mySlider.topPadding + mySlider.availableHeight / 2 - height / 2
        width: 20
        height: 20
        radius: 10
        border.width: 2
        border.color: "lightgrey"
        color: Qt.hsva(x/mySlider.width,1,1)

    }

    background:
    Item
    {
        Rectangle
        {
            id: colorBar
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.margins: 10
            height: 6

            Row
            {
                id:slider
                width:parent.width
                height:10
                Repeater
                {
                    model:parent.width
                    Rectangle
                    {
                        width:1
                        height: colorBar.height
                        color:Qt.hsva(index/slider.width,1,1)
                    }
                }
            }
        }
    }
}

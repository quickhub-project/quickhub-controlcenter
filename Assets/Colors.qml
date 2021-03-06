
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
pragma Singleton

import QtQuick 2.0

QtObject {
    readonly property color black: "#000"
    readonly property color black_op10: transparentColor("000000", 5)
    readonly property color black_op20: transparentColor(black, 20)
    readonly property color orange: "orange"
    readonly property color red: "red"
    readonly property color grey: "grey"
    readonly property color main_orange: "#FF4500"
    readonly property color green: "#3bad03"
    function transparentColor(color, opacity) {
        var number = Math.round(opacity * 2.55)
        number = number.toString(16)
        if (number.length == 1)
            number = 0 + number
        var result = "#" + number + color
        return result
    }
}

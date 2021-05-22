
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

Item {
    FontLoader {
        id: iconFontLoader
        source: "Font Awesome 5 Free-Solid-900.otf"
    }

    readonly property string iconFont: iconFontLoader.name

    readonly property string remove: "" //"
    readonly property string edit: ""
    readonly property string admin: ""
    readonly property string user: ""
    readonly property string add: ""
    readonly property string temp: ""
    readonly property string back: ""
    readonly property string pen: ""
    readonly property string cycle: ""
    readonly property string brush: ""
    readonly property string settings: ""
    readonly property string on: ""
    readonly property string blizzard: ""
    readonly property string arrowdown: ""
    readonly property string check: ""
    readonly property string bidirectionalArrows: ""
    readonly property string star: ""
    readonly property string warning: ""
    readonly property string online: ""
    readonly property string offline: ""
    readonly property string paperClip: ""
}

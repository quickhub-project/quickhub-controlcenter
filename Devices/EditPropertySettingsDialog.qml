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
import QuickHub 1.0
import QtQuick.Layouts 1.1

Dialog
{
    id: dialog

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    property DevicePropertyModel model

    onAccepted: model.unitString  = unitInput.text
    title: model ? model.name :""
    standardButtons: Dialog.Yes | Dialog.Cancel
    width: 300

    Column
    {
        width: parent.width

        Label
        {
            text:"Unit-String"
        }

        TextField
        {
            id: unitInput
            width: parent.width
            text: model ? model.unitString : ""
        }
    }
}

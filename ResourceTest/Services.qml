

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

Item {

    ServiceModel {
        id: serviceModel
        service: resourceField.text
    }

    Item {
        anchors.fill: parent
        anchors.margins: 20
        anchors.topMargin: 60

        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            TextField {
                id: resourceField
                Layout.fillWidth: true
                placeholderText: "Service ID"
            }

            TextField {
                id: call
                Layout.fillWidth: true
                placeholderText: "function name"
            }
            TextArea {
                id: args

                Rectangle {
                    anchors.fill: parent
                    color: "black"
                    opacity: 0.03
                }
                wrapMode: Text.Wrap
                Layout.fillWidth: true
                Layout.fillHeight: true

                placeholderText: "Function arguments (JSON)"
            }

            Button {
                id: btn
                text: "Call"
                Layout.alignment: Qt.AlignRight
                onClicked: serviceModel.call(call.text,
                                             JSON.parse(args.text), btn.cb)

                function cb(data) {
                    result.text = JSON.stringify(data)
                }
            }

            TextArea {
                id: result
                wrapMode: Text.Wrap
                Rectangle {
                    anchors.fill: parent
                    color: "black"
                    opacity: 0.03
                }
                placeholderText: "Answer"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}

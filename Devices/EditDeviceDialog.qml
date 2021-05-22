

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
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2

import "../Assets"
import "../Controls"

Item {
    id: dialog

    ServiceModel {
        id: service
        service: "devices"

        Component.onCompleted: {
            service.call("checkForUpdates", {
                             "mapping": device.resource
                         }, cb)
        }
    }

    function cb(val) {
        console.log(JSON.stringify(val))
        hasUpdate = val.status > 0
        updateInfo = val.info
    }

    property bool hasUpdate
    property var updateInfo
    property DeviceModel device

    function back() {
        StackView.view.pop()
    }

    EditPropertySettingsDialog {
        id: editPropertySettingsDialog
    }

    EditPropertyDialog {
        id: editPropertyDialog
    }

    TriggerRPCDialog {
        id: triggerRPCDialog
        onTrigger: device.triggerFunction(title, arg)
    }

    TextFieldDialog {
        title: "Rename Device"
        placeholderText: device.description != "" ? device.description : device.uuid
        id: editDeviceNameDialog
        onAccepted: device.description = text
    }

    Item {
        id: header
        height: 50
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 20

        RowLayout {
            anchors.fill: parent
            Icon {
                height: parent.height
                width: 50
                iconSize: 20
                icon: Icons.back
                MouseArea {
                    anchors.fill: parent
                    onClicked: dialog.back()
                }
            }

            Column {
                Layout.fillWidth: true
                Label {
                    id: label
                    text: device.description != "" ? device.description : device.uuid
                    font.pixelSize: 24

                    MouseArea {
                        id: labelArea
                        anchors.fill: parent
                        hoverEnabled: true
                        anchors.rightMargin: -30
                    }

                    SmallIconButton {
                        id: button
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: label.right
                        anchors.leftMargin: 5
                        icon: Icons.pen
                        opacity: labelArea.containsMouse | containsMouse ? .4 : 0
                        width: 20
                        height: 20
                        onClicked: {
                            console.log("CLICK")
                            editDeviceNameDialog.open()
                        }
                    }
                }
            }

            Switch {
                checked: device.hasProperty("on") ? device.on : false
                onToggled: device.on = checked
                visible: device.connected && device.hasProperty("on")
            }
        }
    }

    Flickable {
        clip: true
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: header.bottom
        anchors.margins: 20
        contentWidth: width
        contentHeight: layout.height

        Column {
            id: layout
            spacing: 0
            width: parent.width

            Item {
                width: parent.width
                height: 40
                opacity: .5

                Label {
                    width: 180
                    x: 110
                    text: "General Properties"
                    font.weight: Font.Bold
                    anchors.bottom: parent.bottom
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: "black"
                }
            }

            Column {
                width: parent.width
                PropertyFormDelegate {
                    name: "type:"
                    value: device.type
                }

                PropertyFormDelegate {
                    name: "uuid:"
                    value: device.uuid
                }

                PropertyFormDelegate {
                    name: "initialized:"
                    value: device.initialized
                }

                PropertyFormDelegate {
                    name: "available / temporary:"
                    value: device.available
                }

                Item {
                    width: parent.width
                    height: 40
                    visible: hasUpdate

                    Label {
                        id: nameLabel
                        width: 100
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        horizontalAlignment: Text.AlignRight
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Update:"
                        color: "grey"
                    }

                    Button {
                        anchors.verticalCenter: parent.verticalCenter
                        x: 110
                        height: 34
                        text: hasUpdate ? updateInfo.version : ""
                    }
                }
            }

            Item {
                width: parent.width
                height: 40
                opacity: .5
                visible: column.visibleChildren.length > 1
                Label {
                    width: 180
                    x: 110
                    text: "Firmware"
                    font.weight: Font.Bold
                    anchors.bottom: parent.bottom
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: "black"
                }
            }

            Column {
                id: column
                width: parent.width

                Repeater {
                    model: device.properties
                    width: parent.width

                    ItemDelegate {
                        visible: modelData.name.startsWith(".")
                        width: parent.width
                        PropertyFormDelegate {
                            id: del2
                            property bool editableProperty: property
                                                            != undefined ? property.editable : false
                            SmallIconButton {
                                onClicked: {
                                    editPropertyDialog.model = modelData
                                    editPropertyDialog.open()
                                }
                                icon: Icons.edit
                                visible: del2.editableProperty
                                height: parent.height
                            }

                            SmallIconButton {
                                onClicked: {
                                    editPropertySettingsDialog.model = modelData
                                    editPropertySettingsDialog.open()
                                }

                                icon: Icons.settings
                                height: parent.height
                            }

                            transferring: modelData.dirty
                            property: modelData
                            name: modelData.name + ":"
                            value: modelData.value + " " + modelData.unitString
                            hovered: parent.hovered
                        }
                    }
                }
            }

            Item {
                width: parent.width
                height: 40
                opacity: .5
                Label {
                    width: 180
                    x: 110
                    text: "Properties"
                    font.weight: Font.Bold
                    anchors.bottom: parent.bottom
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: "black"
                }
            }

            Repeater {
                //clip:true
                model: device.properties

                ItemDelegate {
                    visible: !modelData.name.startsWith(".")
                    width: parent.width
                    PropertyFormDelegate {
                        id: del1
                        anchors.verticalCenter: parent.verticalCenter
                        property bool editableProperty: property
                                                        != undefined ? property.editable : false
                        SmallIconButton {
                            onClicked: {
                                editPropertyDialog.model = modelData
                                editPropertyDialog.open()
                            }
                            icon: Icons.edit
                            visible: del1.editableProperty
                            height: parent.height
                        }

                        SmallIconButton {
                            onClicked: {
                                editPropertySettingsDialog.model = modelData
                                editPropertySettingsDialog.open()
                            }

                            icon: Icons.settings
                            height: parent.height
                        }

                        transferring: modelData.dirty

                        property: modelData
                        name: modelData.name + ":"
                        value: modelData.value + " " + modelData.unitString

                        hovered: parent.hovered
                    }
                }
            }

            Item {
                width: parent.width
                height: 40
                opacity: .5
                Label {
                    width: 180
                    x: 110
                    text: "Remote Procedure Calls"
                    font.weight: Font.Bold
                    anchors.bottom: parent.bottom
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: "black"
                }
            }

            ListView {
                clip: true
                height: 400
                width: parent.width
                model: device.functions

                delegate: ItemDelegate {
                    width: parent.width
                    height: 40

                    PropertyFormDelegate {
                        name: " "
                        value: modelData.name
                        hovered: parent.hovered

                        SmallIconButton {
                            icon: Icons.blizzard
                            onClicked: device.triggerFunction(modelData.name,
                                                              {})
                            visible: true
                            height: parent.height
                        }

                        SmallIconButton {
                            icon: Icons.paperClip
                            onClicked: {
                                triggerRPCDialog.title = modelData.name
                                triggerRPCDialog.open()
                            }
                            visible: true
                            height: parent.height
                        }
                    }
                }
            }
        }
    }
}

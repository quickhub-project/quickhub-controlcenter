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
import QtQuick.Layouts 1.1
import QuickHub 1.0
import QtQuick.Controls 2.0

import "../Assets"
import "../Controls"

Item
{
    StackView
    {
        id: docroot
        property DeviceModel currentDevice

        anchors.fill: parent
        anchors.topMargin: 50

        TextInputDialog
        {
            id: hookDeviceDialog
            property string uuid
            title:"Device-Provisioning"

            onAccepted:
            {
              onClicked:deviceListModelAll.setMapping(text, uuid)
            }
        }

        Component
        {
            id: editDeviceView
            EditDeviceDialog
            {
                id: editDeviceDialog
                device: docroot.currentDevice
            }
        }

        initialItem:
        Item
        {
            id: deviceOverview

            clip: true
            DeviceHandleListModel
            {
                id: deviceListModel
            }

            DeviceListModel
            {
                id: deviceListModelAll
            }

            RoleFilter
            {
                id: filteredDeviceListModelALl
                sourceModel:deviceListModelAll
                booleanFilterRoleName: "isRegistered";
                inverse: true
            }

            RoleFilter
            {
                id: filter
                searchString: searchInput.text
                stringFilterSearchRole: "type"
                sourceModel: deviceListModel
            }

            ColumnLayout
            {
                anchors.margins: 20
                anchors.fill: parent

                TextField
                {
                    Layout.fillWidth: true
                    id: searchInput
                    placeholderText: "Search"
                }

                Flickable
                {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true
                    contentHeight: content.height

                    Column
                    {
                        id: content
                        width: parent.width

                        Item
                        {
                            visible: newDevicesRepeater.count > 0
                            width: parent.width
                            height: 40

                            Label
                            {
                                text: "Not registered devices"
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5
                                x: 10
                            }
                        }

                        Repeater
                        {
                            id: newDevicesRepeater
                            model: filteredDeviceListModelALl
                            Item
                            {
                                width: parent.width
                                height: 70

                                DeviceDelegate
                                {
                                    _text: shortID == "" ? uuid  : shortID
                                    _type: type
                                    anchors.fill: parent
                                    anchors.margins: 5
                                    _icon: Icons.star

                                    SmallIconButton
                                    {
                                        enabled: online
                                        icon: Icons.online
                                        onClicked:
                                        {
                                            console.log(online)
                                            hookDeviceDialog.uuid = uuid
                                            hookDeviceDialog.open()
                                        }
                                    }
                                }
                            }
                        }

                        Item
                        {
                            width: parent.width
                            height: 40
                            Item
                            {
                                width: parent.width
                                height: 40
                                Label
                                {
                                    text: "Registered devices"
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 5
                                    x: 10
                                }
                            }
                        }

                        Repeater
                        {
                            model: filter
                            Item
                            {
                                width: parent.width
                                height: 70

                                DeviceModel
                                {
                                    id: deviceModelObj
                                    resource: mappings[0]
                                }

                                DeviceDelegate
                                {
                                    anchors.fill: parent
                                    anchors.margins: 5
                                    deviceModel: deviceModelObj
                                    _text: mappings[0]
                                    onClicked:
                                    {
                                       docroot.currentDevice = deviceModelObj
                                       docroot.push(editDeviceView)
                                    }

                                    SmallIconButton
                                    {
                                        icon: Icons.remove
                                        onClicked:deviceListModelAll.setMapping(mappings[0], "")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

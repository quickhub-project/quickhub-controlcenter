import QtQuick 2.0
import QtQuick.Controls 2.2
import QuickHub 1.0
import QtQuick.Layouts 1.1


Dialog
{
    id: dialog
    title: "New User"
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width:300
    height: 300

    function addUserCallback(success, code)
    {
        if( code == QuickHub.UserAlreadyExists)
        {
            addUserStatus.text="User already exists!";
        }

        if(code == QuickHub.PermissionDenied)
        {
            addUserStatus.text="Access Denied!";
        }

        if(code == QuickHub.NoError)
        {
            addUserStatus.text="Success!";
            pass1.text = ""
            pass2.text = ""
            userIdTextField.text = ""
            timer.start()
        }
    }

    Timer
    {
        id:timer
        interval: 1500
        onTriggered: dialog.close()
    }

    ColumnLayout
    {
        spacing: 10
        anchors.fill: parent


        TextField
        {
            Layout.fillWidth: true
            placeholderText: "User ID"
            id: userIdTextField
            onActiveFocusChanged: addUserStatus.text = ""
        }

        TextField
        {
            id: pass1
            Layout.fillWidth: true
            placeholderText: "Password"
            echoMode: TextInput.Password
        }

        TextField
        {
            id: pass2
            Layout.fillWidth: true
            placeholderText: "repeat Password"
            echoMode: TextInput.Password
        }

        Label
        {
            id: addUserStatus
            height: pass2.height
            Layout.fillWidth: true
            text:" "
            horizontalAlignment: Text.AlignRight
        }

        Row
        {

            Button
            {
                highlighted: true
                text:"Cancel"
                flat:true
                onClicked: dialog.close()
            }

            Button
            {
                text:"OK"
                flat:true
                highlighted: true
                enabled: pass1.text == pass2.text && pass1.text!=""
                onClicked: QuickHub.addUser(userIdTextField.text, pass2.text, addUserCallback)
            }
        }
    }
}

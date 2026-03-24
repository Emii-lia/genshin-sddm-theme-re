import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Row {
    id: usernameRow
    spacing: 10
    signal activeFocusChanged

    Button {
        id: userIcon
        width: 44
        height: 44
        visible: true
        enabled: false
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 5
        anchors.topMargin: 20
        icon.source: Qt.resolvedUrl("../icons/character.png")
        icon.height: 44
        icon.width: 44
        background: Rectangle {
            color: "transparent"
            border.color: "transparent"
        }
    }
    TextField {
        id: usernameField
        onActiveFocusChanged: usernameRow.activeFocusChanged()

        height: inputHeight
        width: parent.width
        selectByMouse: true
        echoMode: TextInput.Normal
        selectionColor: config.TextFieldTextColor

        renderType: Text.NativeRendering
        font.pointSize: config.GeneralFontSize
        font.bold: true
        color: config.TextFieldTextColor
        horizontalAlignment: Text.AlignHCenter

        placeholderText: "Username"
        text: userModel.lastUser

        background: Rectangle {
            id: userFieldBackground

            color: "transparent"
            border.color: config.TextFieldBorderColor
            border.width: 1
            radius: config.CornerRadius
        }
        states: [
            State {
                name: "focused"
                when: usernameField.activeFocus
                PropertyChanges {
                    target: userFieldBackground
                    border.color: config.TextFieldBorderColorFocused
                }
            },
            State {
                name: "hovered"
                when: usernameField.hovered
                PropertyChanges {
                    target: userFieldBackground
                    border.color: config.TextFieldBorderColor
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "color, border.width"
                duration: 150
            }
        }
    }
}

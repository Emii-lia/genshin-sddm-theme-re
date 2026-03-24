import QtQuick 2.12
import QtQuick.Controls 2.12

Row {
    id: passwordRow
    spacing: 10
    signal accepted
    property var password: passwordField.text

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
        icon.source: Qt.resolvedUrl("../icons/wish.png")
        icon.height: 44
        icon.width: 44
        background: Rectangle {
            color: "transparent"
            border.color: "transparent"
        }
    }
    TextField {
        id: passwordField

        onAccepted: passwordRow.accepted()

        focus: true
        selectByMouse: true
        placeholderText: "Password"
        echoMode: TextInput.Password
        width: parent.width
        height: inputHeight
        passwordCharacter: "•"
        passwordMaskDelay: 10
        selectionColor: config.TextFieldTextColor

        renderType: Text.NativeRendering
        font.pointSize: config.GeneralFontSize
        font.bold: true
        color: config.TextFieldTextColor
        horizontalAlignment: TextInput.AlignHCenter

        background: Rectangle {
            id: passFieldBg

            color: "transparent"
            border.color: config.TextFieldBorderColor
            border.width: 1
            radius: config.CornerRadius
        }

        states: [
            State {
                name: "focused"
                when: passwordField.activeFocus
                PropertyChanges {
                    target: passFieldBg
                    border.color: config.TextFieldBorderColorFocused
                }
            },
            State {
                name: "hovered"
                when: passwordField.hovered
                PropertyChanges {
                    target: passFieldBg
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

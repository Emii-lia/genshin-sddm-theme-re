import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12

Item {
    implicitHeight: powerButton.height
    implicitWidth: powerButton.width
    readonly property real scaleFactor: (Screen.height > 0 ? Screen.height : 1080) / 1080

    ListModel {
        id: powerModel

        ListElement { icon: "../icons/power.svg" }
        ListElement { icon: "../icons/restart.svg" }
        ListElement { icon: "../icons/sleep.svg" }
    }

    Button {
        id: powerButton

        height: inputHeight
        width: inputHeight
        hoverEnabled: true

        icon.height: height
        icon.width: width
        icon.color: config.PowerIconColor

        background: Rectangle {
            id: powerButtonBg
            
            color: config.PowerButtonColor
            radius: config.CornerRadius
        }

        states: [
            State {
                name: "pressed"
                when: powerButton.down
                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonColor, 1.2)
                }
            },
            State {
                name: "hovered"
                when: powerButton.hovered
                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonColor, 1.2)
                }
            },
            State {
                name: "selection"
                when: powerPopup.visible
                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker(config.PowerButtonColor, 1.2)
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }
        }

        onClicked: {
            powerPopup.visible ? powerPopup.close() : powerPopup.open()
            powerButton.state = "pressed"
            popupSound.play()
        }
    }

    Popup {
        id: powerPopup

        height: inputHeight * 1.2 + padding
        x: powerButton.width + powerList.spacing + 30 * scaleFactor
        y: -height + powerButton.height 
        padding: 15 * scaleFactor

        background: Rectangle {
            radius: config.CornerRadius * 1.8
            color: config.PopupBgColor
        }

        contentItem: ListView {
            id: powerList
            
            implicitWidth: contentWidth
            spacing: 8
            orientation: Qt.Horizontal
            clip: true

            model: powerModel
            delegate: ItemDelegate {
                id: powerEntry

                height: inputHeight
                width: inputHeight

                icon.source: index == 0? Qt.resolvedUrl("../icons/power.png") :
                (index == 1 ? Qt.resolvedUrl("../icons/restart.png") : Qt.resolvedUrl("../icons/sleep.png"))
                icon.color: config.PowerIconColor
                icon.width: height * 0.8
                icon.height: height * 0.8

                background: Rectangle {
                    radius: config.CornerRadius
                    color: powerEntry.hovered
                        ? Qt.darker(config.PopupBgColor, 1.1)
                        : "transparent"
                }

                display: AbstractButton.IconOnly

                onClicked: {
                    powerPopup.close()
                        index == 0 ? sddm.powerOff()
                        : index == 1 ? sddm.reboot()
                            : sddm.suspend()
                }
            }
        }

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }
}

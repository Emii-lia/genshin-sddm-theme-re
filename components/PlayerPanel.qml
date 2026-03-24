import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12


Item {
    implicitHeight: playerButton.height
    implicitWidth: playerButton.width


    readonly property real scaleFactor: Screen.height / 1080
    property var musicDictionary: {
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/snow_buried_tales.mp3": "Snow Buried Tales",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/moonlike_smile.mp3" : "Moonlike Smile",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/unfinished_frescoes.mp3":"Unfinished Frescoes",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/the_flourishing_past.mp3":"The Flourishing Past",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/finale_of_the_snowtomb.mp3":"Finale of The Snowtomb",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/spin_of_the_ice_crystals.mp3":"Spin of The Ice Crystals",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/ballad_of_many_waters.mp3":"Ballad of Many Waters",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/another_hopeful_tomorrow.mp3":"Another Hopeful Tomorr",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/ad_oblivione.mp3":"Ad Oblivione",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/twilight_serenity.mp3":"Twilight Serenity",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/clear_sky_over_liyue.mp3":"Clear Sky over Liyue",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/enchanting_bedtime_stories.mp3":"Enchanting Bedtime Sto",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/glistening_shards.mp3":"Glistening Shards",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/her_serenity.mp3":"The Land of Her Serenity",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/blue_dream.mp3":"Blue Dream",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/song_of_innocence.mp3":"Song of Innocence",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/ruus_melody.mp3":"Ruu's Melody",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/tears_of_days_past.mp3":"Tears of Days Past",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/tales_from_the_snow_mountain.mp3":"Tales from the Snow Mountain",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/lovers_oath.mp3":"Lover's Oath",
    "file:///usr/share/sddm/themes/genshin-sddm-theme/sounds/whisper_of_domus_aurea.mp3":"Whisper of Domus Aurea",
    }

    function currentlyPlaying() {
        var currentMusicPath = musicPlayer.source;
        return musicDictionary[currentMusicPath];
    }

    FontLoader {
        id: electroharmonix
        source: Qt.resolvedUrl(config.FontFamily)
    }

    ListModel {
        id: playerModel

        ListElement { name: "Image" }
        ListElement { name: "Previous" }
        ListElement { name: "Pause" }
        ListElement { name: "Next" }
    }
    Row {
        id: playerRow
        spacing: 20 * scaleFactor

        RoundButton {
            id: playerButton

            height: 40 * scaleFactor
            width: 40 * scaleFactor
            hoverEnabled: true
            icon.source: Qt.resolvedUrl("../icons/play.png")
            icon.width: 36 * scaleFactor
            icon.height: 36 * scaleFactor

            background: Rectangle {
                id: playerButtonBg
                color: config.PlayerButtonColor
                radius: 99
                border.width: 0
            }

            onClicked: {
                playerPopup.visible ? playerPopup.close() : playerPopup.open()
                playerButton.state = "pressed"
                popupSound.play()
            }
        }
        Text {
            id: playerText
            renderType: Text.NativeRendering
            font.pointSize: 24
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: config.PlayerTextColor
            text: currentlyPlaying()
            font.family: electroharmonix.name
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    Popup {
        id: playerPopup

        height: inputHeight * 2 + padding * 2
        x: 10 * scaleFactor
        y: playerRow.height / 2 + 42 * scaleFactor
        padding: 20 * scaleFactor

        background: Rectangle {
            radius: config.CornerRadius * 2
            color: config.PopupBgColor
        }

        contentItem: ListView {
            id: playerList
            
            implicitWidth: contentWidth
            orientation: Qt.Horizontal
            clip: true

            model: playerModel
            delegate: ItemDelegate {
                id: playerEntry

                height: inputHeight * 2
                width: inputHeight * 2               
                        contentItem: Item {
            Image {
                id: playerIcon
                anchors.centerIn: parent
                source: index == 0 ? Qt.resolvedUrl("../icons/snow-buried-tales.jpg") : ""
                sourceSize: Qt.size(playerEntry.width, playerEntry.height)
            }

            

            Item {
                anchors.bottom: parent.bottom
                anchors.right: parent.right 
                width: 80 * scaleFactor
                height: 80 * scaleFactor

                Image {
                    source: index == 1 ? Qt.resolvedUrl("../icons/previous.png") :
                            index == 2 ? Qt.resolvedUrl("../icons/pause.png") : 
                            index == 3 ? Qt.resolvedUrl("../icons/next.png") : ""
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

                transitions: Transition {
                    PropertyAnimation {
                        properties: "color, opacity"
                        duration: 150
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playerPopup.close()
                        index == 0 ? currentlyPlaying() : (index == 1 ? (changeSong(-1),console.log("previous song"),currentlyPlaying()) : (index == 2 ? (changeSong(0),console.log("paused song"),currentlyPlaying()) : (changeSong(1),console.log("next song"),currentlyPlaying())))
                    }
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

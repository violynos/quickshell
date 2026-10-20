import Quickshell
import QtQuick
import QtQuick.Effects

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 24
    color: "transparent"

    readonly property string home: Quickshell.env("HOME")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    // bar background: bg-1 across the full width
    Image {
        anchors.fill: parent
        //source: "file://" + bar.home + "/rice/wallpaper/bg-1.png"
        //fillMode: Image.PreserveAspectCrop
	//verticalAlignment: Image.AlignTop
    }

    // rounded mask for the pill
    Rectangle {
        id: pillMask
        visible: false
        layer.enabled: true
        width: pill.width
        height: pill.height
        radius: height / 2
        color: "white"
    }

    // center pill: a window into bg-2
    Item {
        id: pill
        anchors.centerIn: parent
        width: label.implicitWidth + 28
        height: bar.height

        layer.enabled: true
        layer.effect: MultiEffect {
            maskEnabled: true
            maskSource: pillMask
        }

        // bg-2 is sized to the whole bar and offset by the pill's position,
        // so the pill shows the same part of the picture bg-1 shows there
        Image {
            x: -pill.x
            y: -pill.y
            width: bar.width
            height: bar.height
            source: "file://" + bar.home + "/rice/wallpaper/bg-2.png"
	    fillMode: Image.PreserveAspectCrop
	    verticalAlignment: Image.AlignTop
        }

        Text {
            id: label
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, "HH:mm:ss")
            color: "#cdd6f4"
            font.pixelSize: 12
        }
    }
}

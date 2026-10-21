import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland

import "config.js" as Config

PanelWindow {
	anchors.top:true
	anchors.left: true
	anchors.right: true
	implicitHeight: 24
	color: Config.colors.bg

	RowLayout {
		anchors.fill: parent
		anchors.margins: 4
		
		Repeater {
			model: 5
			Text {
				property var ws: Hyprland.workspaces.values.find(w => w.id === index + 11)
				property bool isActive: Hyprland.focusedWorkspace?.id === (index+11)

				text: isActive ? "—" : (ws ? "–" : "-")

				color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
				font { pixelSize: 12; bold: true }

				MouseArea {
					anchors.fill: parent
					onClicked: Hyprland.dispatch("workspace "+ (index + 11))
				}
			}
		}
		Item { Layout.fillWidth: true }
	}
}

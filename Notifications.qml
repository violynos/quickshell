import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Scope {
	id:root
	property bool centerOpen: false
	NotificationServer {
		id: server
		property var history: ListModel { id: history }
		actionsSupported: true
		bodySupported: true
		imageSupported: true

		onNotification: n => { 
			history.insert(0, {
				summary: n.summary,
				body: n.body,
				appName: n.appName,
				urgency: n.urgency,
				time: Qt.formatDateTime(new Date(), "HH:mm")
			})
			n.tracked = true
		}
	}

	IpcHandler {
		target: "notifications"
		function toggle(): void {root.centerOpen = !root.centerOpen}
		function show(): void {root.centerOpen = true}
		function hide(): void {root.centerOpen = false}
	}

	PanelWindow {
		anchors {top:true;right:true}
		margins {top: 36; right: 12}

		implicitWidth: 380
		implicitHeight: Math.max(1, column.implicitHeight)
		color: "transparent"

		exclusionMode: ExclusionMode.Ignore

		ColumnLayout {
			id: column
			width: parent.width
			spacing: 12

			Repeater {
				model: server.trackedNotifications
				delegate: Rectangle {
					id: card
					required property var modelData

					Timer {
						running: card.modelData.urgency !== NotificationUrgency.Critical
						interval: Config.notifications.timeout
						onTriggered: card.modelData.dismiss()
					}

					Layout.fillWidth: true
					Layout.preferredHeight: layout.implicitHeight+24
					//Layout.preferredHeight: 60
					radius: 8
					color: Config.colors.bg
					border.width: 1
					border.color: modelData.urgency === NotificationUrgency.Critical
					? Config.colors.red : Config.colors.purple

					RowLayout {
						id: layout
						anchors.fill: parent
						anchors.margins: 12
						spacing: 12

						Image {
							Layout.preferredHeight: 36
							Layout.preferredWidth: 36
							Layout.alignment: Qt.AlignTop
							fillMode: Image.PreserveAspectFit
							visible: source.toString() !== ""
							source: card.modelData.image || card.modelData.appIcon || ""
						}

						ColumnLayout {
							Layout.fillWidth: true
							spacing:2

							Text {
								Layout.fillWidth: true
								text: card.modelData.summary
								color: Config.colors.cyan
								font.family: Config.bar.fontFamily
								font.pixelSize: Config.bar.fontSize
								font.bold: true
								elide: Text.ElideRight
							}

							Text {
								Layout.fillWidth: true
								visible: text !== ""
								text: card.modelData.body
								color: Config.colors.fg
								font.family: Config.bar.fontFamily
								font.pixelSize: Config.bar.fontSize - 2
								wrapMode: Text.WordWrap
							}
						}
					}
					MouseArea {
						anchors.fill: parent
						onClicked: card.modelData.dismiss()
					}
				}
			}
		}
	}

	// notification center
	PanelWindow {
		visible: root.centerOpen
		anchors {top:true;right:true}
		margins {top: 36; right: 12}

		implicitWidth: 380
		implicitHeight: centerCol.implicitHeight+24
		color: "transparent"

		exclusionMode: ExclusionMode.Ignore

		Rectangle {

			anchors.fill: parent
			radius: 8
			color: Config.colors.bg
			border.width: 1
			border.color: Config.colors.purple

			ColumnLayout {
				id: centerCol
				width: parent.width
				anchors.fill: parent
				anchors.margins: 12
				spacing: 12

				RowLayout {
					Layout.fillWidth: true

					Text {
						Layout.fillWidth: true
						text: "Notifications"
						color: Config.colors.cyan
						font.family: Config.bar.fontFamily
						font.pixelSize: Config.bar.fontSize + 2
						font.bold: true
						elide: text.ElideRight
					}
					Text {
						text: "Clear All"
						visible: history.count > 0
						color: Config.colors.red
						font.family: Config.bar.fontFamily
						font.pixelSize: Config.bar.fontSize - 1
						font.bold: true

						MouseArea {
							anchors.fill: parent
							onClicked: history.clear()
						}
					}
				}
			}
		}
	}
}


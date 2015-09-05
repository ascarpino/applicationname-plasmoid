/*
 *   Copyright 2012-2015 Andrea Scarpino <scarpino@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {

    Layout.minimumWidth : childrenRect.width
    Layout.minimumHeight : childrenRect.height

    /*
    function configChanged() {
        text.font.family = plasmoid.readConfig("font").toString().split(',')[0]
        text.font.italic = plasmoid.readConfig("italic")
        text.font.underline = plasmoid.readConfig("underline")
        text.color = plasmoid.readConfig("color")

        if (plasmoid.readConfig("bold") === true) {
            text.font.weight = Font.Bold
        } else {
            text.font.weight = Font.Normal
        }
    }
    */

    ListView {
        id: list

        delegate: Item {
            id: itemDelegate

            visible: Active

            Row {
                id: row
                spacing: 3
                anchors.centerIn: parent

                PlasmaCore.IconItem {
                    source: DecorationRole
                    height: text.paintedHeight
                    width: height
                    visible: plasmoid.configuration.showApplicationIcon
                    anchors.verticalCenter: parent.verticalCenter
                }

                PlasmaComponents.Label {
                    id: text
                    text: plasmoid.configuration.showWindowTitle ? GenericName + ' ' + DisplayRole : GenericName
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            PlasmaCore.ToolTipArea {
                id: toolTip

                mainItem: itemDelegate
                mainText: DisplayRole
                icon: DecorationRole
                subText: GenericName
            }
        }
    }

    PlasmaCore.DataSource {
        id: tasksSource
        engine: "tasks"

        onSourceAdded: {
            connectSource(source)
        }

        connectedSources: "tasks"
        Component.onCompleted: {
            print("connected to tasks")
            list.model = models.tasks
        }

        /*
        onDataChanged: {
            // Reset texts
            text.text = ""
            iconItem.source = ""
            tooltip.mainText = ""
            tooltip.subText = ""
            tooltip.image = ""

            if (plasmoid.configuration.showActivityName !== 2) {
                var activityId = activitySource.data["Status"]["Current"]

                text.text = activitySource.data[activityId]["Name"]
                iconItem.source = activitySource.data[activityId]["Icon"]

                tooltip.mainText = text.text
                tooltip.subText = ""
                tooltip.image = iconItem.source
            }

            if (plasmoid.configuration.showActivityName !== 0) {
                for ( var i in models.keys ) {

                    if (data[i].active) {
                        iconItem.source = data[i].icon

                        if (plasmoid.configuration.showWindowTitle) {
                            text.text = data[i].name
                        } else {
                            text.text = data[i].classClass
                        }

                        tooltip.mainText = data[i].classClass
                        tooltip.subText = data[i].name
                        tooltip.image = iconItem.source

                        break
                     }
                }
            }

            if (plasmoid.configuration.useFixedWidth) {
                main.width = plasmoid.configuration.fixedWidthPx

                if (plasmoid.configuration.showApplicationIcon) {
                    text.width = main.width - row.spacing - iconItem.width
                } else {
                    text.width = main.width
                }
                text.elide = Text.ElideRight
            } else {
                if (plasmoid.configuration.showApplicationIcon) {
                    main.width = iconItem.width + row.spacing + text.paintedWidth
                } else {
                    main.width = text.paintedWidth
                }

                text.elide = Text.ElideNone

                if (plasmoid.configuration.useMaximumWidth) {
                    var maximumWidth = plasmoid.configuration.maximumWidthPx
                    if (main.width > maximumWidth) {
                        text.width = maximumWidth - row.spacing - iconItem.width
                        text.elide = Text.ElideRight
                    }
                }

                text.width = text.paintedWidth
            }
        }*/
    }

    PlasmaCore.DataSource {
        id: activitySource
        engine: "org.kde.activities"
        interval: 0

        onSourceAdded: {
            connectSource(source)
        }

        Component.onCompleted: {
            print("connected to activities")
            connectedSources = sources
        }
    }

}

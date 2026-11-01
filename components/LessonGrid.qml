pragma ComponentBehavior: Bound

import QtQuick
import QtQml.Models
import "LessonLayout.js" as LessonLayout

Item {
  id: root

  property var model: []
  property date start
  property date end
  property Component delegate: LessonWrapper {
  }
  property real gap: 2
  property real minItemHeight: 0
  readonly property var placements: __placements
  readonly property int count: __placements.length
  readonly property real dayDuration: end.getTime() - start.getTime()
  readonly property var sourceModel: (model && model.count !== undefined) ? model : null
  property var __placements: []

  function invalidate() {
    __placements = LessonLayout.compute(model, start, end);
  }

  clip: false

  onModelChanged: invalidate()
  onStartChanged: invalidate()
  onEndChanged: invalidate()
  Component.onCompleted: invalidate()

  Connections {
    function onCountChanged() {
      root.invalidate();
    }
    function onObjectMoved() {
      root.invalidate();
    }

    target: root.sourceModel
    ignoreUnknownSignals: true
  }

  Repeater {
    model: root.placements

    delegate: Loader {
      id: slot

      required property var modelData
      readonly property var placement: modelData
      readonly property int lanes: Math.max(1, placement.laneCount)
      readonly property real cellWidth: root.width / lanes
      readonly property real cellHeight: Math.max(root.minItemHeight, root.height * placement.height)
      readonly property real inset: Math.max(0, Math.min(root.gap, cellWidth / 2 - 0.5, cellHeight / 2 - 0.5))

      x: root.width * placement.lane / lanes + inset
      y: root.height * placement.top + inset
      width: Math.max(0, cellWidth - 2 * inset)
      height: Math.max(0, cellHeight - 2 * inset)
      visible: width > 0 && height > 0
      sourceComponent: root.delegate

      Binding {
        target: slot.item
        property: "lesson"
        value: slot.placement.lesson
        when: slot.status === Loader.Ready
      }

      Connections {
        function onStartTimeChanged() {
          root.invalidate();
        }
        function onStopTimeChanged() {
          root.invalidate();
        }

        target: slot.placement.lesson
        ignoreUnknownSignals: true
      }
    }
  }
}

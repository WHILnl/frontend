import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Rectangle {
  id: root

  // Data
  required property date startTime
  required property date stopTime
  required property string title
  property string lessonIndex: ""
  property string location: ""
  property string teacher: ""

  // Styling
  property color backgroundColor: "#fffbfe"
  property color borderColor: Material.dividerColor
  property int borderRadius: 12
  property int borderWidth: 1
  property int padding: 8
  property color primary: Material.accent
  property int seperatorRadius: 3
  property int seperatorWidth: 6
  property int textSpacing: 2
  property string timeFormat: "hh:mm"

  // Derived values
  readonly property string startTimeText: Qt.formatTime(startTime, root.timeFormat)
  readonly property string stopTimeText: Qt.formatTime(stopTime, root.timeFormat)

  radius: borderRadius
  implicitWidth: content.implicitWidth + 2 * (root.padding + root.borderWidth)
  implicitHeight: content.implicitHeight + 2 * (root.padding + root.borderWidth)
  color: backgroundColor
  border.width: root.borderWidth
  border.color: borderColor
  clip: true

  RowLayout {
    id: content

    anchors.fill: parent
    anchors.margins: root.padding + root.borderWidth
    spacing: root.padding

    ColumnLayout {
      id: timeColumn

      Layout.alignment: Qt.AlignTop
      Layout.margins: 1
      spacing: root.textSpacing

      Label {
        id: startTimeLabel

        Layout.alignment: Qt.AlignCenter
        text: root.startTimeText
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        maximumLineCount: 1
      }

      Label {
        Layout.alignment: Qt.AlignCenter
        text: root.stopTimeText
        opacity: 0.6
        font.pixelSize: startTimeLabel.font.pixelSize * 0.8
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
      }
    }

    Rectangle {
      Layout.fillHeight: true
      implicitWidth: root.seperatorWidth
      color: root.primary
      radius: root.seperatorRadius
    }

    ColumnLayout {
      Layout.alignment: Qt.AlignTop | Qt.AlignLeft
      Layout.fillWidth: true
      spacing: root.textSpacing

      Label { // Title
        id: titleLabel

        Layout.fillWidth: true
        text: root.title
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        maximumLineCount: 1
        font.weight: Font.Medium
      }

      Label { // Teacher
        Layout.fillWidth: true
        text: root.teacher
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        maximumLineCount: 1
        font.pixelSize: titleLabel.font.pixelSize * 0.8
        opacity: 0.6
      }
    }

    ColumnLayout {
      Layout.alignment: Qt.AlignTop | Qt.AlignRight
      Layout.fillHeight: true
      spacing: root.textSpacing

      Label { // LessonIndex
        id: lessonIndexLabel

        visible: text.length > 0
        Layout.alignment: Qt.AlignRight
        text: root.location
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        maximumLineCount: 1
        font.bold: true
      }

      Label { // Location
        Layout.alignment: Qt.AlignRight
        text: root.lessonIndex
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        maximumLineCount: 1
        font.pixelSize: lessonIndexLabel.font.pixelSize * 0.9
        opacity: 0.6
      }
    }
  }
}

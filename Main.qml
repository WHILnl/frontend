import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Controls.Material
import "./components"

ApplicationWindow {
  id: win

  readonly property date dayStart: at(8)
  readonly property date dayEnd: at(20)

  function at(hour, minute) {
    var d = new Date();
    d.setHours(hour, minute || 0, 0, 0);
    return d;
  }

  width: 1920
  height: 1080
  visible: true
  Material.accent: Material.Blue
  title: qsTr("LessonGrid")

  LessonData {
    startTime: win.at(8, 0)
    stopTime: win.at(9, 30)
    title: "hi"
  }

  ObjectModel {
    id: lessons

    LessonData {
      lessonIndex: "u01"
      startTime: win.at(8, 30)
      stopTime: win.at(9, 20)
      title: "nat"
      location: "019"
      teacher: "vss"
    }

    LessonData {
      lessonIndex: "u02"
      startTime: win.at(9, 20)
      stopTime: win.at(10, 10)
      title: "schk"
      location: "111"
      teacher: "sho"
    }

    LessonData {
      lessonIndex: "u03"
      startTime: win.at(10, 30)
      stopTime: win.at(11, 20)
      title: "schk"
      location: "111"
      teacher: "sho"
    }

    LessonData {
      lessonIndex: "u04"
      startTime: win.at(11, 20)
      stopTime: win.at(12, 10)
      title: "nat"
      location: "019"
      teacher: "vss"
    }

    LessonData {
      lessonIndex: "u06"
      startTime: win.at(13, 30)
      stopTime: win.at(14, 20)
      title: "biol"
      location: "017"
      teacher: "rijk"
    }

    LessonData {
      lessonIndex: "u07"
      startTime: win.at(14, 35)
      stopTime: win.at(15, 25)
      title: "wisb"
      location: "014"
      teacher: "dmr"
    }
  }

  LessonGrid {
    id: grid

    anchors.fill: parent
    anchors.margins: 16
    start: win.dayStart
    end: win.dayEnd
    model: lessons

    delegate: LessonWrapper {
    }
  }
}

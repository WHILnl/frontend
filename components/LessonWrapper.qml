import QtQuick

Item {
  id: root

  property LessonData lesson: null
  readonly property date __epoch: new Date(0)

  Lesson {
    anchors.fill: parent
    visible: root.lesson !== null && root.lesson !== undefined
    startTime: root.lesson ? root.lesson.startTime : root.__epoch
    stopTime: root.lesson ? root.lesson.stopTime : root.__epoch
    title: root.lesson ? root.lesson.title : ""
    location: root.lesson ? root.lesson.location : ""
    lessonIndex: root.lesson ? root.lesson.lessonIndex : -1
    teacher: root.lesson ? root.lesson.teacher : ""
  }
}

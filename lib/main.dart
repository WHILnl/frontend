import 'package:flutter/material.dart';
import 'package:whil_frontend/components/lesson.dart';
import 'package:whil_frontend/components/lessonGrid.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final DateTime start = DateTime.now().copyWith(hour: 8, minute: 0);
  final DateTime end = DateTime.now().copyWith(hour: 17, minute: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 800,
            height: 900,
            child: LessonGrid(
              [
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 8, minute: 30),
                  start.copyWith(hour: 9, minute: 20),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 8, minute: 30),
                  start.copyWith(hour: 9, minute: 20),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 8, minute: 30),
                  start.copyWith(hour: 9, minute: 20),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 9, minute: 20),
                  start.copyWith(hour: 10, minute: 10),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 10, minute: 30),
                  start.copyWith(hour: 11, minute: 20),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 10, minute: 30),
                  start.copyWith(hour: 12, minute: 10),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 11, minute: 20),
                  start.copyWith(hour: 12, minute: 10),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 12, minute: 40),
                  start.copyWith(hour: 13, minute: 30),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 13, minute: 30),
                  start.copyWith(hour: 14, minute: 20),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 14, minute: 35),
                  start.copyWith(hour: 15, minute: 25),
                  lessonIndex: "1ste",
                ),
                Lesson(
                  "Nederlands",
                  "201",
                  "Braams",
                  start.copyWith(hour: 15, minute: 25),
                  start.copyWith(hour: 14, minute: 15),
                  lessonIndex: "1ste",
                ),
              ],
              start,
              end,
            ),
          ),
        ),
      ),
    );
  }
}

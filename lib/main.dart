import 'package:flutter/material.dart';
import 'package:whil_frontend/components/lesson.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 800,
          height: 1000,
          child: Column(
            children: [
              for (int i = 0; i <= 9; i++)
                SizedBox(
                  width: 800,
                  height: 80,
                  child: LessonWidget(
                    "Nederlands",
                    "100",
                    "Smits",
                    DateTime(2026),
                    DateTime(2026),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

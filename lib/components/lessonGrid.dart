import 'package:flutter/material.dart';
import 'package:whil_frontend/components/lesson.dart';

class _Placement {
  _Placement({
    required this.lesson,
    required this.top,
    required this.height,
    required this.lane,
  });

  final Lesson lesson;
  final double top;
  final double height;
  final int lane;
  int laneCount = 1;
}

class LessonGrid extends StatelessWidget {
  LessonGrid(this.lessons, this.start, this.end, {super.key})
    : dayDuration = end.difference(start).inMilliseconds;

  final DateTime start;
  final DateTime end;
  final List<Lesson> lessons;
  final int dayDuration;

  late final List<_Placement> _placements = _compute();

  double _dateFraction(DateTime time) {
    if (dayDuration == 0) return 0;
    return time.difference(start).inMilliseconds / dayDuration;
  }

  List<_Placement> _compute() {
    final sorted = [...lessons]..sort((a, b) => a.start.compareTo(b.start));

    final placements = <_Placement>[];
    final laneEnds = <DateTime>[];

    var stackedLessonStart = 0;
    DateTime? stackedLessonMaxEnd;

    void setLaneCounts() {
      // updates lessons with their new lane counts so that they can devide their width correctly
      final laneCount = laneEnds.length;
      for (var i = stackedLessonStart; i < placements.length; i++) {
        placements[i].laneCount = laneCount;
      }
    }

    for (final lesson in sorted) {
      final startsNew =
          stackedLessonMaxEnd == null ||
          !lesson.start.isBefore(stackedLessonMaxEnd);

      if (startsNew) {
        setLaneCounts();
        stackedLessonStart = placements.length;
        laneEnds.clear();
        stackedLessonMaxEnd = null;
      }

      var lane = 0;
      while (lane < laneEnds.length && laneEnds[lane].isAfter(lesson.start)) {
        lane++;
      }
      if (lane == laneEnds.length) {
        laneEnds.add(lesson.stop);
      } else {
        laneEnds[lane] = lesson.stop;
      }

      stackedLessonMaxEnd =
          (stackedLessonMaxEnd == null ||
              lesson.stop.isAfter(stackedLessonMaxEnd))
          ? lesson.stop
          : stackedLessonMaxEnd;

      placements.add(
        _Placement(
          lesson: lesson,
          top: _dateFraction(lesson.start),
          height: _dateFraction(lesson.stop) - _dateFraction(lesson.start),
          lane: lane,
        ),
      );
    }

    setLaneCounts();
    return placements;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final p in _placements)
              Positioned(
                left: w * p.lane / p.laneCount,
                top: h * p.top,
                width: w / p.laneCount,
                height: h * p.height,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(2),
                  child: LessonWidget(p.lesson),
                ),
              ),
          ],
        );
      },
    );
  }
}

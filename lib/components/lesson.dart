import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class Lesson {
  const Lesson(
    this.lesson,
    this.classroom,
    this.teacher,
    this.start,
    this.stop, {
    this.lessonIndex = "",
  });

  final String lessonIndex;
  final String lesson;
  final String classroom;
  final String teacher;
  final DateTime start;
  final DateTime stop;
}

class LessonWidget extends StatelessWidget {
  const LessonWidget(
    this.lessonData, {
    super.key,
    this.enableLessonIndex = true,
  });
  final bool enableLessonIndex;
  final Lesson lessonData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BaseLessonWidget(
          lessonData,
          enableLessonIndex: constraints.maxHeight > 60,
        );
      },
    );
  }
}

class BaseLessonWidget extends StatelessWidget {
  const BaseLessonWidget(
    this.lessonData, {
    super.key,
    this.enableLessonIndex = true,
  });
  final bool enableLessonIndex;
  final Lesson lessonData;

  String _formatTime(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tijden
          Container(
            width: 56,
            color: theme.colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentGeometry.topCenter,
              child: Column(
                children: [
                  Text(
                    _formatTime(lessonData.start),
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _formatTime(lessonData.stop),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  if (enableLessonIndex &&
                      lessonData.lessonIndex.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        lessonData.lessonIndex,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ],
              ),
            ),
          ),

          // Separator
          Container(width: 4, color: accent),

          // Les
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentGeometry.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lessonData.lesson,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      lessonData.teacher,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Lokaal tag
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Chip(
                    avatar: const Icon(Icons.meeting_room_outlined, size: 16),
                    label: Text(
                      lessonData.classroom,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@Preview(name: "Lesson")
Widget previewLessonWidget() {
  return BaseLessonWidget(
    Lesson(
      "Nederlands",
      "208",
      "vinken, bah",
      DateTime(2026, 12, 10, 11, 20),
      DateTime(2026, 12, 10, 12, 10),
    ),
  );
}

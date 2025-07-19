import 'package:fitness_app_riverpod/models/exercise.dart';
import 'package:fitness_app_riverpod/models/workout.dart';

class Progress {
  final String id;
  final String workoutId;
  final List<ExerciseProgress> exerciseProgresses;
  final DateTime date;

  Progress({
    required this.id,
    required this.workoutId,
    required this.exerciseProgresses,
    required this.date,
});

  Progress copyWith({
    String? workoutId,
    List<ExerciseProgress>? exerciseProgresses,
    DateTime? date,
}) {
    return Progress(
      id: id,
      workoutId: workoutId ?? this.workoutId,
      exerciseProgresses: exerciseProgresses ?? this.exerciseProgresses,
      date: date ?? this.date,
    );
  }
}

class ExerciseProgress {
  final String exerciseId;
  final int setsCompleted;
  final int repsCompleted;
  final Duration timetaken;

  ExerciseProgress({
    required this.exerciseId,
    required this.setsCompleted,
    required this.repsCompleted,
    required this.timetaken,
});

  ExerciseProgress copyWith({
    int? setsCompleted,
    int? repsCompleted,
    Duration? timetaken,
}) {
    return ExerciseProgress(
      exerciseId: exerciseId,
      setsCompleted: setsCompleted ?? this.setsCompleted,
      repsCompleted: repsCompleted ?? this.repsCompleted,
      timetaken: timetaken ?? this.timetaken,
    );
  }
}



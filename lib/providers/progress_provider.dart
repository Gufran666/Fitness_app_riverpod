import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/progress.dart';
import 'package:fitness_app_riverpod/models/workout.dart';

final List<Progress> sampleProgress = [
  Progress(
    id: '1',
    workoutId: '1',
    exerciseProgresses: [
      ExerciseProgress(
        exerciseId: '1-1',
        setsCompleted: 3,
        repsCompleted: 10,
        timetaken: const Duration(minutes: 5),
      ),
      ExerciseProgress(
        exerciseId: '1-2',
        setsCompleted: 3,
        repsCompleted: 12,
        timetaken: const Duration(minutes: 6),
      ),
    ],
    date: DateTime(2023, 10, 1),
  ),
  Progress(
    id: '2',
    workoutId: '1',
    exerciseProgresses: [
      ExerciseProgress(
        exerciseId: '1-1',
        setsCompleted: 3,
        repsCompleted: 12,
        timetaken: const Duration(minutes: 4),
      ),
      ExerciseProgress(
        exerciseId: '1-2',
        setsCompleted: 3,
        repsCompleted: 15,
        timetaken: const Duration(minutes: 5),
      ),
    ],
    date: DateTime(2023, 10, 8),
  ),
];

class ProgressNotifier extends StateNotifier<List<Progress>> {
  ProgressNotifier() : super(sampleProgress);

  void addProgress(Progress progress) {
    state = [...state, progress];
  }

  void updateProgress(Progress updatedProgress) {
    state = state.map((progress) {
      return progress.id == updatedProgress.id ? updatedProgress : progress;
    }).toList();
  }

  void deleteProgress(String id) {
    state = state.where((progress) => progress.id != id).toList();
  }

  List<Progress> getProgressByWorkoutId(String workoutId) {
    return state.where((progress) => progress.workoutId == workoutId).toList();
  }

  List<Progress> getProgressByDateRange(DateTime start, DateTime end) {
    return state.where((progress) {
      return progress.date.isAfter(start) && progress.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, List<Progress>>((ref) {
  return ProgressNotifier();
});
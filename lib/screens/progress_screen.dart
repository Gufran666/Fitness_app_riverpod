import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/workout.dart';
import 'package:fitness_app_riverpod/models/progress.dart';
import 'package:fitness_app_riverpod/providers/workout_provider.dart';
import 'package:fitness_app_riverpod/providers/progress_provider.dart';
import 'package:fitness_app_riverpod/widgets/progress_chart.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutProvider);
    final progresses = ref.watch(progressProvider);
    final selectedWorkoutId = ref.watch(selectedWorkoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedWorkoutId,
              items: workouts.map((workout) {
                return DropdownMenuItem(
                  value: workout.id,
                  child: Text(workout.name),
                );
              }).toList(),
              onChanged: (value) {
                ref.read(selectedWorkoutProvider.notifier).state = value!;
              },
              decoration: InputDecoration(
                labelText: 'Select Workout',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: selectedWorkoutId != null
                  ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: workouts.firstWhere((workout) => workout.id == selectedWorkoutId).exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = workouts.firstWhere((workout) => workout.id == selectedWorkoutId).exercises[index];
                        final exerciseProgresses = progresses
                            .where((progress) => progress.workoutId == selectedWorkoutId)
                            .expand((progress) => progress.exerciseProgresses)
                            .where((exerciseProgress) => exerciseProgress.exerciseId == exercise.id)
                            .toList();

                        return exerciseProgresses.isNotEmpty
                            ? ProgressChart(
                          workoutId: selectedWorkoutId,
                          exerciseId: exercise.id,
                        )
                            : Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text('No progress data available'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
                  : const Center(
                child: Text('Select a workout to view progress'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final selectedWorkoutProvider = StateNotifierProvider<SelectedWorkoutNotifier, String?>((ref) {
  return SelectedWorkoutNotifier();
});

class SelectedWorkoutNotifier extends StateNotifier<String?> {
  SelectedWorkoutNotifier() : super(null);

  void updateSelectedWorkout(String? workoutId) {
    state = workoutId;
  }
}
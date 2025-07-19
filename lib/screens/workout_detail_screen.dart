import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/workout.dart';
import 'package:fitness_app_riverpod/providers/workout_provider.dart';
import 'package:fitness_app_riverpod/widgets/exercise_tile.dart';

import '../models/exercise.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final String workoutId;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(workoutProvider).firstWhere(
          (workout) => workout.id == workoutId,
      orElse: () => Workout(
        id: '',
        name: '',
        description: '',
        exercises: [],
        duration: Duration.zero,
        difficultyLevel: 0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit workout screen (to be implemented)
              // Navigator.pushNamed(context, '/edit-workout', arguments: workoutId);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (workout.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    workout.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                workout.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(workout.description),
              const SizedBox(height: 20),
              const Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...workout.exercises.map(
                    (exercise) => ExerciseTile(exercise: exercise),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Start workout (to be implemented)
                    // Navigator.pushNamed(context, '/workout-start', arguments: workoutId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Start Workout',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;

  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (exercise.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  exercise.imageUrl!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(exercise.description),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.repeat,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text('${exercise.sets} sets'),
                const SizedBox(width: 15),
                Icon(
                  Icons.replay,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text('${exercise.reps} reps'),
                const SizedBox(width: 15),
                Icon(
                  Icons.hourglass_empty,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text('${exercise.restTime.inSeconds} sec rest'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
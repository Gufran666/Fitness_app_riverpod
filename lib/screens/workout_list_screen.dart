import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/workout.dart';
import 'package:fitness_app_riverpod/providers/workout_provider.dart';
import 'package:fitness_app_riverpod/screens/workout_detail_screen.dart';

class WorkoutListScreen extends ConsumerWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Can navigate to a new screen here

            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: workouts.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return WorkoutCard(
              workout: workout,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailScreen(workoutId: workout.id),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (workout.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    workout.imageUrl!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                workout.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(workout.description),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text('${workout.duration.inMinutes} min'),
                  const SizedBox(width: 15),
                  Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(workout.difficultyLevel.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
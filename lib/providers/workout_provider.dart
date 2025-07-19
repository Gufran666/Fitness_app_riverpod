import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/workout.dart';

import '../models/exercise.dart';

// Sample workout data
final List<Workout> sampleWorkouts = [
  Workout(
    id: '1',
    name: 'Full Body Strength',
    description: 'A full-body strength training workout for beginners.',
    exercises: [
      Exercise(
        id: '1-1',
        name: 'Push-Ups',
        description: 'Start in a plank position and lower your body until your chest nearly touches the floor.',
        imageUrl: 'assets/pushup.jpg',
        sets: 3,
        reps: 10,
        restTime: const Duration(seconds: 60),
      ),
      Exercise(
        id: '1-2',
        name: 'Bodyweight Squats',
        description: 'Stand with feet shoulder-width apart and lower your body as if sitting in a chair.',
        imageUrl: 'assets/squats.jpg',
        sets: 3,
        reps: 12,
        restTime: const Duration(seconds: 60),
      ),
    ],
    imageUrl: 'https://www.example.com/full-body.jpg',
    duration: const Duration(minutes: 30),
    difficultyLevel: 1,
  ),
  Workout(
    id: '2',
    name: 'Cardio Blast',
    description: 'A high-intensity cardio workout to get your heart pumping.',
    exercises: [
      Exercise(
        id: '2-1',
        name: 'Jumping Jacks',
        description: 'Jump while spreading your legs and raising your arms, then return to the starting position.',
        imageUrl: 'assets/jumpingjacks.png',
        sets: 4,
        reps: 20,
        restTime: const Duration(seconds: 30),
      ),
      Exercise(
        id: '2-2',
        name: 'Mountain Climbers',
        description: 'In a plank position, alternate bringing your knees towards your chest.',
        imageUrl: 'assets/mountainclimber.jpeg',
        sets: 4,
        reps: 15,
        restTime: const Duration(seconds: 30),
      ),
    ],
    imageUrl: 'https://www.example.com/cardio.jpg',
    duration: const Duration(minutes: 20),
    difficultyLevel: 2,
  ),
];

class WorkoutNotifier extends StateNotifier<List<Workout>> {
  WorkoutNotifier() : super(sampleWorkouts);

  void addWorkout(Workout workout) {
    state = [...state, workout];
  }

  void updateWorkout(Workout updatedWorkout) {
    state = state.map((workout) {
      return workout.id == updatedWorkout.id ? updatedWorkout : workout;
    }).toList();
  }

  void deleteWorkout(String id) {
    state = state.where((workout) => workout.id != id).toList();
  }

  Workout getWorkoutById(String id) {
    return state.firstWhere((workout) => workout.id == id);
  }
}

final workoutProvider = StateNotifierProvider<WorkoutNotifier, List<Workout>>((ref) {
  return WorkoutNotifier();
});
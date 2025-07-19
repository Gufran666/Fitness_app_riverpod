import 'package:fitness_app_riverpod/models/exercise.dart';

class Workout {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises;
  final String? imageUrl;
  final Duration duration;
  final int difficultyLevel;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    this.imageUrl,
    required this.duration,
    required this.difficultyLevel,
  });

  Workout copyWith({
    String? name,
    String? description,
    List<Exercise>? exercises,
    String? imageUrl,
    Duration? duration,
    int? difficultyLevel,
  }) {
    return Workout(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
    );
  }
}
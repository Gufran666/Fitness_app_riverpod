class Exercise {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final int sets;
  final int reps;
  final Duration restTime;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.sets,
    required this.reps,
    required this.restTime,
  });

  Exercise copyWith({
    String? name,
    String? description,
    String? imageUrl,
    int? sets,
    int? reps,
    Duration? restTime,
  }) {
    return Exercise(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restTime: restTime ?? this.restTime,
    );
  }
}
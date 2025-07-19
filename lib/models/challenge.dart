class Challenge {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final int targetWorkouts;
  final int participants;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.targetWorkouts,
    required this.participants,
  });

  Challenge copyWith({
    String? name,
    String? description,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    int? targetWorkouts,
    int? participants,
  }) {
    return Challenge(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      targetWorkouts: targetWorkouts ?? this.targetWorkouts,
      participants: participants ?? this.participants,
    );
  }
}
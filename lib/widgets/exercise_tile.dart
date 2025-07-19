import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;

  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (exercise.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  exercise.imageUrl!,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              exercise.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              exercise.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _infoIconText(Icons.repeat, '${exercise.sets} sets', context),
                const SizedBox(width: 16),
                _infoIconText(Icons.replay, '${exercise.reps} reps', context),
                const SizedBox(width: 16),
                _infoIconText(
                  Icons.timer_outlined,
                  '${exercise.restTime.inSeconds}s rest',
                  context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoIconText(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}

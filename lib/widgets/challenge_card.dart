import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/challenge.dart';
import 'package:fitness_app_riverpod/providers/challenge_providers.dart';
import 'package:intl/intl.dart';

class ChallengeCard extends ConsumerWidget {
  final Challenge challenge;
  final VoidCallback onJoin;
  final VoidCallback onLeave;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onJoin,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isJoined = ref.watch(challengeProvider).any((c) => c.id == challenge.id && c.participants > 0);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (challenge.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  challenge.imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              challenge.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(challenge.description),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  '${DateFormat('MM/dd').format(challenge.startDate)} - ${DateFormat('MM/dd').format(challenge.endDate)}',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.track_changes,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),

                const SizedBox(width: 5),
                Text('${challenge.targetWorkouts} workouts'),
                const Spacer(),
                Icon(
                  Icons.group,
                  color: Theme.of(context).primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text('${challenge.participants} participants'),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isJoined ? onLeave : onJoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isJoined ? Colors.red : Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isJoined ? 'Leave Challenge' : 'Join Challenge',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
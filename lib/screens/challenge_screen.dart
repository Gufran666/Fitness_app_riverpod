import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/challenge.dart';
import 'package:fitness_app_riverpod/providers/challenge_providers.dart';
import 'package:fitness_app_riverpod/widgets/challenge_card.dart';

class ChallengeScreen extends ConsumerWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challenges = ref.watch(challengeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to create challenge screen (to be implemented)
              // Navigator.pushNamed(context, '/create-challenge');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final challenge = challenges[index];
            return ChallengeCard(
              challenge: challenge,
              onJoin: () => ref.read(challengeProvider.notifier).joinChallenge(challenge.id),
              onLeave: () => ref.read(challengeProvider.notifier).leaveChallenge(challenge.id),
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/challenge.dart';

// Sample challenges
final List<Challenge> sampleChallenges = [
  Challenge(
    id: '1',
    name: '30-Day Fitness Challenge',
    description: 'Complete a workout every day for 30 days.',
    imageUrl: 'https://www.example.com/challenge1.jpg',
    startDate: DateTime(2023, 10, 1),
    endDate: DateTime(2023, 10, 30),
    targetWorkouts: 30,
    participants: 150,
  ),
  Challenge(
    id: '2',
    name: ' Weekly Sprint',
    description: 'Complete 5 cardio sessions in a week.',
    imageUrl: 'https://www.example.com/challenge2.jpg',
    startDate: DateTime(2023, 10, 1),
    endDate: DateTime(2023, 10, 7),
    targetWorkouts: 5,
    participants: 75,
  ),
];

class ChallengeNotifier extends StateNotifier<List<Challenge>> {
  ChallengeNotifier() : super(sampleChallenges);

  void addChallenge(Challenge challenge) {
    state = [...state, challenge];
  }

  void joinChallenge(String challengeId) {
    state = state.map((challenge) {
      if (challenge.id == challengeId) {
        return challenge.copyWith(participants: challenge.participants + 1);
      }
      return challenge;
    }).toList();
  }

  void leaveChallenge(String challengeId) {
    state = state.map((challenge) {
      if (challenge.id == challengeId) {
        return challenge.copyWith(participants: challenge.participants - 1);
      }
      return challenge;
    }).toList();
  }

  void updateChallengeProgress(String challengeId, int workoutsCompleted) {
    // Logic to update challenge progress
  }
}

final challengeProvider = StateNotifierProvider<ChallengeNotifier, List<Challenge>>((ref) {
  return ChallengeNotifier();
});
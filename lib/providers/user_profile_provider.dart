import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfileNotifier extends StateNotifier<User> {
  final FlutterSecureStorage _storage;
  final String _userId;

  UserProfileNotifier(this._storage, this._userId, User initialUser)
    : super(initialUser);
  Future<void> loadUserProfile() async {
    await Future.delayed(Duration(seconds: 1));

    final sampleUser = User(
      id: _userId,
      email: await _storage.read(key: 'userEmail') ?? '',
      name: 'Arham Gufran',
      profilePictureUrl: 'assets/real - Copy.PNG',
      bio: 'Fitness enthusiast and tech lover',
      weight: 70,
      height: 175,
      dateofBirth: DateTime(1990, 1, 1),
    );

    state = sampleUser;
  }

  Future<void> updateProfile({
    String? name,
    String? profilePictureUrl,
    String? bio,
    int? weight,
    int? height,
    DateTime? dateOfBirth,
}) async {
    state = state.copyWith(
      name: name ?? state.name,
      profilePictureUrl: profilePictureUrl ?? state.profilePictureUrl,
      bio: bio ?? state.bio,
      weight: weight ?? state.weight,
      height: height ?? state.height,
      dateofBirth: dateOfBirth ?? state.dateofBirth,
    );

    await Future.delayed(Duration(seconds: 1));
  }
}

final userProfileProvider = StateNotifierProvider.family<UserProfileNotifier, User, String>((ref, userId) {
  final storage = FlutterSecureStorage();
  final initialUser = User(id: userId, email: '');
  return UserProfileNotifier(storage, userId, initialUser);
});
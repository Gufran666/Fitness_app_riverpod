import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/social_post.dart';

// Sample social posts
final List<SocialPost> samplePosts = [
  SocialPost(
    id: '1',
    userId: 'user1',
    userName: 'John Doe',
    content: 'Completed my first full-body workout! Feeling great.',
    imageUrl: 'https://www.example.com/workout1.jpg',
    createdAt: DateTime(2023, 10, 1),
    likes: 24,
    comments: 5,
  ),
  SocialPost(
    id: '2',
    userId: 'user2',
    userName: 'Jane Smith',
    content: 'Trying out a new cardio routine. It was intense but rewarding!',
    imageUrl: 'https://www.example.com/cardio.jpg',
    createdAt: DateTime(2023, 10, 2),
    likes: 18,
    comments: 3,
  ),
];

class SocialNotifier extends StateNotifier<List<SocialPost>> {
  SocialNotifier() : super(samplePosts);

  void addPost(SocialPost post) {
    state = [post, ...state];
  }

  void likePost(String postId) {
    state = state.map((post) {
      if (post.id == postId) {
        return post.copyWith(likes: post.likes + 1);
      }
      return post;
    }).toList();
  }

  void addComment(String postId) {
    state = state.map((post) {
      if (post.id == postId) {
        return post.copyWith(comments: post.comments + 1);
      }
      return post;
    }).toList();
  }
}

final socialProvider = StateNotifierProvider<SocialNotifier, List<SocialPost>>((ref) {
  return SocialNotifier();
});

// Provider for user follows
final followsProvider = StateNotifierProvider<FollowsNotifier, Set<String>>((ref) {
  return FollowsNotifier();
});

class FollowsNotifier extends StateNotifier<Set<String>> {
  FollowsNotifier() : super(Set<String>());

  void followUser(String userId) {
    if (!state.contains(userId)) {
      state = {...state, userId};
    }
  }

  void unfollowUser(String userId) {
    if (state.contains(userId)) {
      state = Set.from(state.where((id) => id != userId));
    }
  }
}
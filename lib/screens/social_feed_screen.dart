import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_app_riverpod/models/social_post.dart';
import 'package:fitness_app_riverpod/providers/social_provider.dart';
import 'package:fitness_app_riverpod/providers/follows_provider.dart';
import 'package:fitness_app_riverpod/widgets/social_post_card.dart';

class SocialFeedScreen extends ConsumerWidget {
  const SocialFeedScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final follows = ref.watch(followsProvider);
    final posts = ref.watch(socialProvider);
    
    final followedPosts = posts.where((post) => follows.contains(post.userId)).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add),
            onPressed: () {
              // Can navigate to create_post Screen from here
            },
          ),
        ],
      ),
      body: followedPosts.isEmpty
        ? const Center(
        child: Text('Follow someone to see there posts'),
      )
          : ListView.builder(
        itemCount: followedPosts.length,
        itemBuilder: (context, index) {
          final post = followedPosts[index];
          return SocialPostCard(
            post: post,
            onLike: () => ref.read(socialProvider.notifier).likePost(post.id),
            onComment: () => ref.read(socialProvider.notifier).addComment(post.id),
          );
        }
      )
    );
  }
}
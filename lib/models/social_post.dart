class SocialPost {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final int likes;
  final int comments;

  SocialPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });

  SocialPost copyWith({
    String? userId,
    String? userName,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    int? likes,
    int? comments,
  }) {
    return SocialPost(
      id: id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
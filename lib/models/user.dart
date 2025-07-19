class User {
  final String id;
  final String email;
  String name;
  String? profilePictureUrl;
  String? bio;
  int? weight;
  int? height;
  DateTime? dateofBirth;

  User({
    required this.id,
    required this.email,
    this.name = '',
    this.profilePictureUrl,
    this.bio,
    this.weight,
    this.height,
    this.dateofBirth,
});

  User copyWith({
    String? name,
    String? profilePictureUrl,
    String? bio,
    int? weight,
    int? height,
    DateTime? dateofBirth,
}) {
    return User(
      id: id,
      email: email,
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      bio: bio ?? this.bio,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      dateofBirth: dateofBirth ?? this.dateofBirth,
    );
  }
}

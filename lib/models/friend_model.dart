class Friend {
  final String id;
  final String email;
  final String profilePic;

  Friend({
    required this.id,
    required this.email,
    required this.profilePic,
  });
  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['_id'],
      email: json['email'],
      profilePic: json['profilePic'],
    );
  }
}

class User {
  final int id;
  final String userId;
  final String? name;
  final String? email;
  final String? picture;

  User(
      {required this.id,
      required this.userId,
      required this.name,
      required this.email,
      required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        picture: json['picture']);
  }
}

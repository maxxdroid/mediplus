class LocalUser {
  String name;
  String email;
  String imageUrl;
  String role;
  String userID;

  LocalUser(
      {required this.name,
      required this.role,
      required this.imageUrl,
      required this.userID,
      required this.email});

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
        name: json['name'],
        email: json['email'],
        imageUrl: json['imageUrl'],
        userID: json['userID'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'imageUrl': imageUrl,
      'userID' : userID
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalUser &&
        other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.role == role &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        role.hashCode ^
        userID.hashCode;
  }
}

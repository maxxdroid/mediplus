class Report {
  String name;
  String medication;
  String imageUrl;
  String description;
  String userID;
  String email;

  Report(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.userID,
      required this.email,
      required this.medication});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        name: json['name'],
        medication: json['medication'],
        imageUrl: json['imageUrl'],
        userID: json['userID'],
        email: json['email'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'medication': medication,
      'description': description,
      'imageUrl': imageUrl,
      'email': email,
      'userID': userID
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Report &&
        other.name == name &&
        other.medication == medication &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.userID == userID &&
        other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        medication.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        userID.hashCode ^
        email.hashCode;
  }
}
